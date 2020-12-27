#                    |
#          _  /  __| __ \   __| __|
#            / \__ \ | | | |   (
#          ___|____/_| |_|_|  \___|
#                                     
#
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
zstyle :compinstall filename '"$HOME"/.zshrc'
autoload -Uz compinit promptinit
compinit
promptinit

## history settings
HISTFILE=~/.zsh_history
HISTSIZE=15000
SAVEHIST=15000

## misc setopt(s)
setopt autocd extendedglob COMPLETE_ALIASES NO_CASE_GLOB
unsetopt beep

# actual prompts
# TODO make timestamp only appear on sent commands
#PROMPT='%B%F{#E2D2F9}%n %2~ >> %f%b%(?..%F{red}[%?]%f) '
PROMPT='%B%F{magenta}%n %2~%f%b %F{red}❥ %(?..[%?])%f '
#PROMPT='%B%F{magenta}% %2~%f%b %F{red}❥ %(?..[%?])%f '
## ^^^^ no name

RPROMPT='[%*]'

## evals/sources
export PATH="$HOME"/bin:"$HOME"/.cargo/bin:"$HOME"/.local/bin:$GOPATH/bin:$PATH
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
[[ -f "$HOME"/.zsh_aliases ]] && source "$HOME"/.zsh_aliases

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

# record a window with `giph`, passing it the $WINDOWID
recordWindow ()
{
	video_dir=/home/jam/videos/giph
	if (( $# = 2 )); then
		giph -w "${1}" "${video_dir}/${2}"
	else
		giph -w "${1}" "${video_dir}/$( date '+%Y-%m-%dT%H:%M:%S' )"
	fi
}

## plugin management with zinit for speed
source ~/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# plugins
zinit for \
	light-mode zsh-users/zsh-autosuggestions \
	light-mode zdharma/fast-syntax-highlighting \
	light-mode wookayin/fzf-fasd \

zinit wait'2' lucid for \
    light-mode OMZP::fasd \
    light-mode ael-code/zsh-colored-man-pages \
