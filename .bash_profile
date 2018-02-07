#
# ~/.bash_profile
#

# Load .bashrc for login shells
[[ -f ~/.bashrc ]] && source ~/.bashrc

# Auto-exec startx when logging with tty1
if [[ ! ${DISPLAY} && ${XDG_VTNR} == 1 && ! "${TERM}" =~ "screen".* ]]; then
    exec startx
fi
