# Set locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Limit make verbosity
export GNUMAKEFLAGS=--no-print-directory

# Set default text editor
# export EDITOR=nvim

# Source local profile if any
if [ -f $HOME/.profile.local ]; then
    source $HOME/.profile.local
fi

# Add ruby gems to the $PATH
if which ruby &>/dev/null && which gem &>/dev/null; then
    PATH="$(ruby -e 'puts Gem.user_dir')/bin:$PATH"
    export GEM_HOME=$HOME/.gem
fi

# Set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# [-]ixany  let any character restart output, not only start character
# [-]ixoff  enable sending of start/stop characters
# [-]ixon   enable XON/XOFF flow control
#
# This is a trade-off for extra keys!
# Disable this if remote connections become unreliable.
stty -ixon -ixoff ixany
stty start undef
stty stop undef

# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        source "$HOME/.bashrc"
    fi
fi
