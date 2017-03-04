#!/usr/bin/env bash

# call with a prompt string or use a default
confirm()
{
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

link()
{
    local from="$1"
    local to="$2"
    echo "Linking '$from' to '$to'"
    #rm -f "$to"
    ln -s "$from" "$to"
}

REPO=~/dotfiles

echo 'Installing from' $REPO
link {$REPO,$HOME}/.aliases

link {$REPO,$HOME}/.dircolors
link {$REPO,$HOME}/.profile

link {$REPO,$HOME}/.gitconfig
link {$REPO,$HOME}/.gdbinit

# htop Setup
mkdir -p $HOME/.config/htop
link {$REPO,$HOME}/.config/htop/htoprc

echo 'Zsh setup...'
link {$REPO,$HOME}/.zshrc
wget -O $HOME/.zshrc_grml http://git.grml.org/f/grml-etc-core/etc/zsh/zshrc

echo 'Ranger setup...'
mkdir -p $HOME/.config/ranger
link $REPO/.config/ranger/colorschemes $HOME/.config/ranger
link {$REPO,$HOME}/.config/ranger/rc.conf

echo 'Vim setup...'
link $REPO/.vim $HOME
link {$REPO,$HOME}/.vimrc
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
    link {$REPO,$HOME}/.config/i3/config
    link {$REPO,$HOME}/.config/i3status/config
    link $REPO/.Xresources.d $HOME
    link {$REPO,$HOME}/.Xresources
fi

echo 'done'
