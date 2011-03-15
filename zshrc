# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/daniel/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#COLORS
BLACK='\e[0;30m'
BLUE='\e[0;34m'
GREEN='\e[0;32m'
CYAN='\e[0;36m'
RED='\e[0;31m'
PURPLE='\e[0;35m'
BROWN='\e[0;33m'
LIGHTGRAY='\e[0;37m'
DARKGRAY='\e[1;30m'
LIGHTBLUE='\e[1;34m'
LIGHTGREEN='\e[1;32m'
LIGHTCYAN='\e[1;36m'
LIGHTRED='\e[1;31m'
LIGHTPURPLE='\e[1;35m'
YELLOW='\e[1;33m'
LIGHTYELLOW='\e[0;33m'
WHITE='\e[1;37m'
NC='\e[0m'              # No Color

# prompt
if [ $(whoami) = "root" ]; then
    PS1=$'%{\e[01;31m%}%n@%m %{\e[01;34m%}%~ %# %{\e[0m%}'
else
    PS1=$'%{\e[01;32m%}%n@%m %{\e[01;34m%}%~ %# %{\e[0m%}'
fi

EDITOR='vim'

export PATH=~/.cabal/bin:$PATH

autoload colors zsh/terminfo

REPORTTIME=20
setopt NOCLOBBER

# ALIASES
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lA'
alias nano='nano -w'
alias tc='sudo truecrypt -t'
alias mosml='rlwrap mosml'
alias mtr='mtr --curses'

alias apti='sudo aptitude install'
alias apts='aptitude search'
alias aptr='sudo aptitude remove'
alias apt='sudo aptitude'



if [ `hostname` = "daniel-laptop" ]; then
#    . ~/src/z/z.sh
#    function precmd() {
#        z --add "$(pwd -P)"
#    }
else
    if [ ""$TERM = "rxvt-256color" ]; then
        export TERM=rxvt-unicode
    fi
fi

# completion

zstyle ':completion:*' format '%SCompleting %U%d%u%s'
zstyle :completion::complete:cd:: tag-order \
                   local-directories path-directories

zstyle ':completion:*' auto-description 'specify %d:'
zstyle ':completion:*' completer _expand _complete _files
zstyle ':completion:*' expand prefix
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'r:|[._-]=* r:|=*' 'r:|[._-]=* r:|=*' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' menu select=0
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' verbose true

# colored man pages
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;37m") \
        LESS_TERMCAP_md=$(printf "\e[1;37m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;47;30m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[0;36m") \
            man "$@"
}

