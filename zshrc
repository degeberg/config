#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

type fasd > /dev/null && eval "$(fasd --init auto)"

type ipython > /dev/null && alias py='ipython'
type matlab > /dev/null && alias matlabnd='matlab -nodesktop -nosplash'
unalias rm
unalias sl

if [ -d /opt/cuda/bin ]; then
    export PATH=$PATH:/opt/cuda/bin
fi

export EDITOR=vim
export SYSTEMD_EDITOR=vim

export MPD_HOST=~/.mpd/socket
