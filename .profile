# Set locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

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
