#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Simple prompt
PS1='\W \$ '

if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

# Manage this file
alias edit_rc='$EDITOR ~/.bashrc'
alias reload='source ~/.bashrc'

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    source /etc/bash_completion
fi

# Source local bashrc if any
if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi
