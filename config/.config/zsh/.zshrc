# Zoomer Shell: Based on Luke's Config

# Luke's config for the Zoomer Shell

# Enable colors and change prompt:
autoload -U colors && colors

parse_git_branch() {
  git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1 /'
}

parse_nix_shell() {
  [ -z $IN_NIX_SHELL ] || {
    echo "($IN_NIX_SHELL nix-shell) "
  }
}

check_fysh() {
  string=$(pwd)
  word="fysh"
  lb="["
  name="%n"
  host="%M"
  eye=""
  rb="]"
  # Check if the directory has fysh
  test "${string#*"$word"}" != "$string" && {
    lb="><"
    name="charles"
    host="fysh-fyve"
    eye="%{$reset_color%}°"
    rb=">"
  }
  echo "%B%{$fg[red]%}$lb%{$fg[yellow]%}$name%{$fg[green]%}@%{$fg[blue]%}$host %{$fg[cyan]%}$(parse_git_branch)%{$fg[green]%}$(parse_nix_shell)%{$fg[magenta]%}%c$eye%{$fg[red]%}$rb%{$reset_color%}$%b "
}


setopt PROMPT_SUBST
# PROMPT="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[cyan]%}\$(parse_git_branch)%{$fg[green]%}\$(parse_nix_shell)%{$fg[magenta]%}%c%{$fg[red]%}]%{$reset_color%}$%b "
PROMPT="\$(check_fysh)"

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
_comp_options+=(globdots) # Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

bindkey '^r' history-incremental-search-backward

bindkey -s ^f "tmux-sessionizer\n"
# bindkey -s ^r "tmux-sessionizer-nvim\n"
bindkey -s ^g "lg\n"
# bindkey -s ^t "vi ~/.dotfiles/personal/todo.md\n"
bindkey -s ^n "z notes; vi .\n"

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
echo -ne '\e[5 q'                # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q'; } # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd() {
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
autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

for file in $ZDOTDIR/{.shortcutrc,.envrc,.aliasrc}; do
  [ -f "$file" ] && source "$file"
done

if type pyenv &>/dev/null; then
  eval "$(pyenv init -)"
fi

if type zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

#if type obs &>/dev/null; then
#  eval "$(obs completion zsh)"
#fi

lg() {
    # export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    # if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
    #         cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
    #         rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    # fi
}

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
