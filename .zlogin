#
# ~/.zlogin
#

# Auto-exec wm when logging with tty1
if [[ ! ${DISPLAY} && ${XDG_VTNR} == 1 && ! "${TERM}" =~ "screen".* ]]; then
    XKB_DEFAULT_LAYOUT=us,fr XKB_DEFAULT_OPTIONS=grp:alt_shift_toggle exec sway
fi
