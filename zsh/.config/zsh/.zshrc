# Zoomer Shell: Based on Luke's Config

# Luke's config for the Zoomer Shell

# Enable colors and change prompt:
autoload -U colors && colors

parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1 /'
}


setopt PROMPT_SUBST
PROMPT="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[cyan]%}\$(parse_git_branch)%{$fg[magenta]%}%c%{$fg[red]%}]%{$reset_color%}$%b "

# artix style prompt, ugly colours tho
# PS1="%B%{$fg[cyan]%}%M%{$reset_color%}:%{$fg[red]%}[%{$fg[blue]%}%n%{$fg[red]%}]%{$reset_color%}:%{$fg[magenta]%}%~%{$fg[yellow]%}$%{$reset_color%}%b "

# History in cache directory:
HISTSIZE=999999999
SAVEHIST=999999999
HISTFILE=~/.cache/zsh/history
[ -f "$HISTFILE" ] || {
	mkdir -p $(dirname $HISTFILE)
	touch $HISTFILE
}

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load aliases and shortcuts if existent.
# Make sure to set $DOTFILE_DIR
shortcut_file="$HOME/.config/zsh/.shortcutrc"
alias_file="$HOME/.config/zsh/.aliasrc"
[ -f "$shortcut_file" ] && source "$shortcut_file"
[ -f "$alias_file" ] && source "$alias_file"

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# Source goto
[[ -s "/usr/local/share/goto.sh" ]] && source /usr/local/share/goto.sh
