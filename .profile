# Set locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Source local profile if any
if [ -f $HOME/.profile.local ]; then
    source $HOME/.profile.local
fi

export PATH="$HOME/.local/bin:$PATH"

# [-]ixany  let any character restart output, not only start character
# [-]ixoff  enable sending of start/stop characters
# [-]ixon   enable XON/XOFF flow control
#
# This is a trade-off for extra keys!
# Disable this if remote connections become unreliable.
stty -ixon -ixoff ixany
stty start undef
stty stop undef

