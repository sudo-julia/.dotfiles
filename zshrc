## completion options
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' verbose true
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion::complete:*' gain-privileges 1
zstyle :compinstall filename '/home/jam/.zshrc'
autoload -Uz compinit promptinit
compinit
promptinit

## history settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

## misc setopt(s)
setopt autocd extendedglob COMPLETE_ALIASES NO_CASE_GLOB
unsetopt beep

## prompt
# grab git branch
parse_git_branch () {
    [ "$PWD" = "$HOME" ] && return
    ref="$(command git symbolic-ref --short HEAD 2> /dev/null)" || return
    echo " [$ref]"
}

# git vcs on prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '%F{#FBD588}%B%b%%b%f'

# actual prompts
PROMPT='%B%F{#E2D2F9}%n %2~ >> %f%b%(?..%F{red}[%?]%f) '

#RPROMPT="$vcs_info_msg_0_ [%*]"
RPROMPT='[%*]'

## evals/exports/sources
#eval "$(hub alias -s)"
export EDITOR=/usr/bin/vim
export GOPATH=/home/jam/Programming/Go
export PATH=/home/jam/bin:/home/jam/.cargo/bin:/home/jam/.local/bin:$PATH
export TERM=alacritty
export WINEPREFIX=/home/jam/wine
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
source /home/jam/.config/nnn/config
[[ -f /home/jam/.zsh_aliases ]] && source /home/jam/.zsh_aliases

## key bindings
# editor mode
bindkey -v

# history fuzzy search
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search 
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search # up arrow
bindkey '^[[B' down-line-or-beginning-search # down arrow
#### TODO: Add keys to delete line from beginning to end and vice versa

# movement within line
bindkey '^[[1;5C' forward-word # right arrow w control
bindkey '^[[1;5D' backward-word # left arrow w control
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

## functions
# make and change into directory
mkcd ()
{
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}

# make backup of config file with menu if no arg is given
# TODO use shift to operate on as many args as given
mkbak ()
{
    if [ $# -eq 0 ]; then
	backup=$(readlink -m ~/.config/*/* | grep -Evi 'chromium|usr' | fzf)
	if [ "$backup" = '' ]; then
	    (exit 1)
	else
	    while [ -n "$1" ]; do
		cp -a -- "$1" "$1.bak"
		shift
		done
	fi
    else
	cp -a -- "$@" "$@.bak"
    fi
}

# update all pip packages

## plugin management with zinit for speed
source ~/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit light wookayin/fzf-fasd

zinit wait lucid for \
    OMZ::plugins/fasd/fasd.plugin.zsh \
    OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

