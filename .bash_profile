#
# ~/.bash_profile
#

# Load .bashrc for login shells
[[ -f ~/.bashrc ]] && source ~/.bashrc

# Auto-exec wm when logging with tty1
if [[ ! ${DISPLAY} && ${XDG_VTNR} == 1 && ! "${TERM}" =~ "screen".* ]]; then
    # Enable wayland backend for GTK+ apllications
    #export GDK_BACKEND=wayland
    # Start sway
    exec sway
fi
