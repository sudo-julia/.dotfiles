#                    |
#          _  /  __| __ \   __| __|
#            / \__ \ | | | |   (
#          ___|____/_| |_|_|  \___|
                                     

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
zstyle :compinstall filename "${HOME}/.zshrc"
autoload -Uz compinit promptinit
compinit -d "${HOME}/lib/zcompdump" # throw the compdump here instead of polluting $HOME
promptinit

## history settings
HISTFILE="${HOME}/lib/zsh_history"
HISTSIZE=15000
SAVEHIST=15000

## misc setopt(s)
setopt extendedglob COMPLETE_ALIASES NO_CASE_GLOB
unsetopt beep

# actual prompts
# TODO make timestamp only appear on sent commands
#PROMPT='%B%F{#E2D2F9}%n %2~ >> %f%b%(?..%F{red}[%?]%f) '
PROMPT='%B%F{magenta}%n %2~%f%b %F{red}❥ %(?..[%?])%f '
RPROMPT='[%D{%T}]'
#RPROMPT='[%D{%H:%M:%S}'

## evals/sources
eval "$( pyenv init - )"
export PATH="${HOME}/bin:${HOME}/.local/bin:${PATH}"
source '/usr/share/fzf/key-bindings.zsh'
source '/usr/share/fzf/completion.zsh'
[[ -f "${HOME}/.zsh_aliases" ]] && source "${HOME}/.zsh_aliases"

## key bindings
# editor mode
bindkey -v

## fzf settings
_fzf_compgen_path() {
	fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
	fd --type d --hidden --follow --exclude ".git" . "$1"
}

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
# compile and run c program
cr() {
	if [ "${1:(-2)}" != ".c" ]; then
		printf -- '%s is not a c file.\n' "'$1'"
		return 1
	fi
	if [ ! -d './bin' ]; then
		mkdir './bin'
	fi
	outfile="./bin/${1:0:(-2)}"
	if [ -z "${outfile}" ] && [ "${outfile}" -nt "$1" ]; then
		"${outfile}"
	else
		cc "$1" -o "${outfile}" \
		&& shift \
		&& "${outfile}" "$@"
	fi
	unset outfile
}

get-audio() {
	youtube-dl -x --audio-format best "$1"
}

# make and change into directory
mkcd() {
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}

# build python project in current dir
pybuild() {
	python3 './setup.py' sdist bdist_wheel
}

## plugin management with zinit for speed
source "${HOME}/.zinit/bin/zinit.zsh"
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
