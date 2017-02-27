#!/usr/bin/env bash

# The script assumes this path
REPO=~/dotfiles

echo 'Installing from' $REPO
ln -s {$REPO,$HOME}/.aliases

ln -s {$REPO,$HOME}/.dircolors
ln -s {$REPO,$HOME}/.profile

ln -s {$REPO,$HOME}/.gitconfig
ln -s {$REPO,$HOME}/.gdbinit

# htop Setup
mkdir -p $HOME/.config/htop
ln -s {$REPO,$HOME}/.config/htop/htoprc

echo 'Zsh setup...'
ln -s {$REPO,$HOME}/.zshrc
wget -O $HOME/.zshrc_grml http://git.grml.org/f/grml-etc-core/etc/zsh/zshrc

echo 'Ranger setup...'
mkdir -p $HOME/.config/ranger
ln -s $REPO/.config/ranger/colorschemes $HOME/.config/ranger
ln -s {$REPO,$HOME}/.config/ranger/rc.conf

echo 'Vim setup...'
ln -s $REPO/.vim $HOME
ln -s {$REPO,$HOME}/.vimrc
mkdir -p $HOME/.vim/{backup,swap,undo}
vim +PluginInstall +qall

if whiptail --yesno "Vim plugins post-install?" 8 30
then
    echo 'Post-install...'
    # Install powerline patched fonts
    $HOME/.vim/bundle/powerline-fonts/install.sh
    # Setup YCM
    # requires some libs first, check the help (:h Ycm)
    $HOME/.vim/bundle/YouCompleteMe/install.py --clang-completer
fi

# i3 Setup
if whiptail --yesno "Install i3?" 8 24
then
    echo 'i3 setup...'
    mkdir -p $HOME/.config/i3
    ln -s {$REPO,$HOME}/.config/i3/config
    ln -s $REPO/.Xresources.d $HOME
    ln -s {$REPO,$HOME}/.Xresources
fi
echo 'done'
