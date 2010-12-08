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

autoload colors zsh/terminfo

if [ -d $HOME/bin ]; then
    PATH=$PATH:/$HOME/bin
fi

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
alias apti='sudo aptitude install'
alias apts='aptitude search'
