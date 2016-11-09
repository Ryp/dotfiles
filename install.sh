#!/usr/bin/env bash

# The script assumes this path
REPO=~/dotfiles/

ln -s {$REPO,~/}.aliases

ln -s {$REPO,~/}.zshrc
wget -O ~/.zshrc_grml http://git.grml.org/f/grml-etc-core/etc/zsh/zshrc

ln -s {$REPO,~/}.profile

ln -s {$REPO,~/}.vimrc
ln -s {$REPO,~/}.vim
mkdir -p ~/.vim/{backup,swap,undo}

ln -s {$REPO,~/}.gitconfig
ln -s {$REPO,~/}.gdbinit

