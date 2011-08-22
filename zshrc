# Path to your oh-my-zsh configuration.
export ZSH=$HOME/projects/oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="kphoen"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git pacman rxvt-unicode z)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

unsetopt correct_all

# fix terminal on remote systems
if [ $(hostname) != "daniel-laptop" ] && [ $(hostname) != "daniel-eee" ] && [ $TERM = "rxvt-unicode-256color" ]; then
    export TERM=rxvt-unicode
fi
