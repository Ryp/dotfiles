#
# ~/.zlogin
#

# Auto-exec startx when logging with tty1
if [[ ! ${DISPLAY} && ${XDG_VTNR} == 1 && ! "${TERM}" =~ "screen".* ]]; then
   exec startx
fi
