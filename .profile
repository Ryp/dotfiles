# Set locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Limit make verbosity
export GNUMAKEFLAGS=--no-print-directory

# Source local profile if any
if [ -f $HOME/.profile.local ]; then
    source $HOME/.profile.local
fi

# Add ruby gems to the $PATH
if which ruby &>/dev/null && which gem &>/dev/null; then
    PATH="$(ruby -e 'puts Gem.user_dir')/bin:$PATH"
    export GEM_HOME=$HOME/.gem
fi

# Add commonly used local bin folder
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
