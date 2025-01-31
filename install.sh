#!/usr/bin/env bash

# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source $SCRIPT_DIR/install_minimal.sh

link_file {$REPO,$HOME}/.gdbinit
link_file {$REPO,$HOME}/.zlogin

if confirm "Install NeoVim?"
then
    link_folder $REPO/.config/nvim $HOME/.config
fi

if confirm "Install vim YCM?"
then
    # Setup YCM
    # requires some libs first, check the help (:h Ycm)
    $HOME/.vim/plugged/YouCompleteMe/install.py --clang-completer
fi

if confirm "Install cmus cfg?"
then
    mkdir -p $HOME/.config/cmus
    link_file {$REPO,$HOME}/.config/cmus/rc
fi

if confirm "Install sway cfg?"
then
    mkdir -p $HOME/.config/sway
    link_file {$REPO,$HOME}/.config/sway/config

    # i3status is still used to generate the text for swaybar
    mkdir -p $HOME/.config/i3status
    link_file {$REPO,$HOME}/.config/i3status/config
fi

if confirm "Install ghostty cfg?"
then
    mkdir -p $HOME/.config/ghostty
    link_file {$REPO,$HOME}/.config/ghostty/config
fi

if confirm "Install custom scripts?"
then
    mkdir -p $HOME/.local/bin
    link_file {$REPO,$HOME/.local}/bin/set_wallpaper
fi
