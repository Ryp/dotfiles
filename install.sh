#!/usr/bin/env bash

# The script assumes this path
REPO=~/dotfiles/

echo 'Installing from' $REPO
ln -s {$REPO,~/}.aliases

ln -s {$REPO,~/}.dircolors
ln -s {$REPO,~/}.profile

ln -s {$REPO,~/}.gitconfig
ln -s {$REPO,~/}.gdbinit

# htop Setup
mkdir -p ~/.config/htop
ln -s {$REPO,~/}.config/htop/htoprc

# Zsh setup
echo 'Zsh setup...'
ln -s {$REPO,~/}.zshrc
wget -O ~/.zshrc_grml http://git.grml.org/f/grml-etc-core/etc/zsh/zshrc

echo 'Vim setup...'
ln -s {$REPO,~/}.vimrc
ln -s {$REPO,~/}.vim
mkdir -p ~/.vim/{backup,swap,undo}
vim +PluginInstall +qall

if whiptail --yesno "Vim plugins post-install?" 8 30
then
    echo 'Post-install...'
    # Install powerline patched fonts
    ~/.vim/bundle/powerline-fonts/install.sh
    # Setup YCM
    # requires some libs first, check the help (:h Ycm)
    ~/.vim/bundle/YouCompleteMe/install.py --clang-completer
fi

# i3 Setup
if whiptail --yesno "Install i3?" 8 24
then
    echo 'i3 setup...'
    mkdir -p ~/.config/i3
    ln -s {$REPO,~/}.config/i3/config
    ln -s {$REPO,~/}.Xresources.d
    ln -s {$REPO,~/}.Xresources
fi

echo 'done'
