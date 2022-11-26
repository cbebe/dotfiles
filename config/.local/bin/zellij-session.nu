#!/usr/bin/env nu

let dox = (fd --hidden --min-depth 1 --max-depth 1 . ~/dox | lines)
let work = (fd --hidden --min-depth 1 --max-depth 1 . ~/work | lines)
let dirs = [. ~/dox ~/ ~/work ~/repos]
let dots = [~/.dotfiles ~/.dotfiles/config/.config ~/.dotfiles/config/.local]

def select_with_fzf [] {
	let entries = ([$dirs $dots $dox $work] | flatten)
	let result = (fd --hidden . $entries --min-depth 0 --max-depth 1)

	($result | lines | path expand | where ($it | path type) == 'dir' | uniq |
	reduce { |it, acc| $acc + (char nl) + $it } | fzf)
}

def select_dir [selected] {
	let valid_path = ($selected | path type) == "dir"
	if not $valid_path { echo (select_with_fzf) } else { echo $selected }
}

def find_match [session] {
	(zellij list-sessions | lines | each { |it| $it | split words | get 0 } |
	where $it == $session | length) == 1
}

def main [selected = ""] {
	let dir = (select_dir $selected | str trim)
	if $dir == "" { print --stderr "No directory selected"; exit }

	let session = ($dir | path basename | str replace --all ' ' '-' | str replace --all '\.' '')
	if (find_match $session) {
		# TODO: Find a way to switch sessions
		zellij attach $session
	} else {
		cd $dir
		SHELL=nu zellij --session $session
	}
}
