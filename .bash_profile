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
    XKB_DEFAULT_LAYOUT=us,fr XKB_DEFAULT_OPTIONS=grp:alt_shift_toggle exec sway
fi
