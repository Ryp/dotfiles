# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Be pedantic about unset variables
set -u

export SHELL_RC_FILE=$HOME/.bashrc

# Simple green prompt
PS1='\[\e[0;32m\]\u@\h \[\e[0;34m\]\w\[\e[0;00m\] \$ '

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    source /etc/bash_completion
fi

# Source local bashrc if any
if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi

source ~/.shrc
