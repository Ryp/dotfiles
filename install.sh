#!/usr/bin/env bash

# call with a prompt string or use a default
confirm() {
    read -r -p "${1:-Are you sure?} [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            false
            ;;
    esac
}

REPO=${1:~/dotfiles}

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

if confirm "Vim plugins post-install?"
then
    # Install powerline patched fonts
    $HOME/.vim/bundle/powerline-fonts/install.sh
    # Setup YCM
    # requires some libs first, check the help (:h Ycm)
    $HOME/.vim/bundle/YouCompleteMe/install.py --clang-completer
fi

if confirm "Install i3?"
then
    mkdir -p $HOME/.config/i3
    mkdir -p $HOME/.config/i3status
    ln -s {$REPO,$HOME}/.config/i3/config
    ln -s {$REPO,$HOME}/.config/i3status/config
    ln -s $REPO/.Xresources.d $HOME
    ln -s {$REPO,$HOME}/.Xresources
fi

echo 'done'
