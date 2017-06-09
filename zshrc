# Support locally installed zim instead of system-wide
if [ -e ~/.zim/init.zsh ]; then
    source ~/.zim/init.zsh
fi

bindkey -e

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

(( $+commands[ipython] )) && alias py='ipython'
(( $+commands[matlab] )) && alias matlabnd='matlab -nodesktop -nosplash'

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

# JIX stuff:
if [ $(hostname) = "gnu" ]; then
    [ -e /home/perl/bin ] && PATH=/home/perl/bin:$PATH
    PATH=$PATH:$JOBXXHOME/bin:$HOME/bin

    source ~/jobxx/conf/jix-env.zsh

    ulimit -Sv unlimited
    ulimit -Sd unlimited

    function m {
        mysql "job${1:=xx}"
    }
fi
