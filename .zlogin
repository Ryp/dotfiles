#
# ~/.zlogin
#

# Auto-exec wm when logging with tty1
if [[ ! ${DISPLAY} && ${XDG_VTNR} == 1 && ! "${TERM}" =~ "screen".* ]]; then
    # Enable wayland backend for GTK+ apllications
    #export GDK_BACKEND=wayland
    export MOZ_ENABLE_WAYLAND=1

    # Start sway
    exec sway
fi
