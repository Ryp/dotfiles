#!/usr/bin/env bash

# The script assumes this path
REPO=~/dotfiles/

ln -s {$REPO,~/}.aliases

# Setup dicolors
ln -s {$REPO,~/}.dircolors

# Zsh setup
ln -s {$REPO,~/}.zshrc
wget -O ~/.zshrc_grml http://git.grml.org/f/grml-etc-core/etc/zsh/zshrc

ln -s {$REPO,~/}.profile

ln -s {$REPO,~/}.gitconfig
ln -s {$REPO,~/}.gdbinit

# Vim setup
ln -s {$REPO,~/}.vimrc
ln -s {$REPO,~/}.vim
mkdir -p ~/.vim/{backup,swap,undo}
vim +PluginInstall +qall

# Install powerline patched fonts
~/.vim/bundle/powerline-fonts/install.sh

# i3 Setup
mkdir -p ~/.config/i3
ln -s {$REPO,~/}.config/i3/config
ln -s {$REPO,~/}.Xresources.d
ln -s {$REPO,~/}.Xresources

# htop Setup
mkdir -p ~/.config/htop
ln -s {$REPO,~/}.config/htop/htoprc

