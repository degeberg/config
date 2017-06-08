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

#type fasd > /dev/null && eval "$(fasd --init auto)"

(( $+commands[ipython] )) && alias py='ipython'
(( $+commands[matlab] )) && alias matlabnd='matlab -nodesktop -nosplash'
unalias rm
unalias sl

if [ -d /opt/cuda/bin ]; then
    export PATH=$PATH:/opt/cuda/bin
fi


if (( $+commands[nvim] )) ; then
    export EDITOR=nvim
else
    export EDITOR=vim
fi
export SYSTEMD_EDITOR=$EDITOR

export MPD_HOST=~/.mpd/socket

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_CTRL_R_OPTS='--sort --exact'
