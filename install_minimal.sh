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

# Interactively create symlinks to prevent potential damage
# $1 src, $2 dest
link_file()
{
    local src="$1"
    local dest="$2"

    # Ensure we are linking to a existing file.
    if ! [ -f $src ]
    then
        echo $src 'is not a file!'
        exit 1
    fi

    if [ $src -ef $dest ]
    then
        # Symlink is pointing to the same file, nothing to do.
        echo $dest 'is up-to-date.'
    elif [ -L $dest ]
    then
        # Symlink exists but does not point to the same thing,
        # force it to the new destination.
        ln -svfT "$src" "$dest"
        echo $dest 'updated.'
    elif [ -e $dest ]
    then
        # File exists but is not a symlink, ask if we want to overwrite it.
        if confirm "$dest is not a symlink, try to overwrite it anyway?"
        then
            ln -svfT "$src" "$dest"
        fi
    else
        # Symlink does not exist at all, create it.
        ln -svT "$src" "$dest"
    fi
}

# Same function for folders
link_folder()
{
    local src="$1"
    local dest_dir="$2"

    # Ensure we are linking to a existing folder.
    if ! [ -d $src ]
    then
        echo $src 'is not a file!'
        exit 1
    fi

    local dest_full="$dest_dir/`basename $src`"

    if [ $src -ef $dest_full ]
    then
        # Symlink is pointing to the same file, nothing to do.
        echo $dest_full 'is up-to-date.'
    elif [ -L $dest_full ]
    then
        # Symlink exists but does not point to the same thing,
        # force it to the new destination.
        ln -svf -t "$dest_dir" "$src"
        echo $dest_full 'updated.'
    elif [ -e $dest_full ]
    then
        # File exists but is not a symlink, ask if we want to overwrite it.
        if confirm "$dest_full is not a symlink, try to overwrite it anyway?"
        then
            ln -svf -t "$dest_dir" "$src"
        fi
    else
        # Symlink does not exist at all, create it.
        ln -sv -t "$dest_dir" "$src"
    fi
}

# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
REPO=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo 'Installing from' $REPO

link_file {$REPO,$HOME}/.profile
link_file {$REPO,$HOME}/.dircolors
link_file {$REPO,$HOME}/.config/user-dirs.dirs
link_file {$REPO,$HOME}/.aliases
link_file {$REPO,$HOME}/.gitconfig

if confirm "Install bash cfg?"
then
    link_file {$REPO,$HOME}/.bashrc
    link_file {$REPO,$HOME}/.bash_profile
fi

if confirm "Install zsh cfg?"
then
    link_file {$REPO,$HOME}/.zshrc
    wget -O $HOME/.zshrc_grml http://git.grml.org/f/grml-etc-core/etc/zsh/zshrc
fi

if confirm "Install vim cfg?"
then
    link_folder $REPO/.vim $HOME
    link_file {$REPO,$HOME}/.vimrc
    mkdir -p $HOME/.vim/{backup,swap,undo,cache,autoload}
    cp $REPO/{external/vim-plug/plug.vim,.vim/autoload}

    vim +PlugInstall +qall

    # Install powerline patched fonts
    $HOME/.vim/plugged/powerline-fonts/install.sh
fi

if confirm "Install tmux cfg?"
then
    link_file {$REPO,$HOME}/.tmux.conf
    link_folder $REPO/.tmux $HOME
fi

if confirm "Install ranger cfg?"
then
    mkdir -p $HOME/.config/ranger
    link_folder $REPO/.config/ranger/colorschemes $HOME/.config/ranger
    link_file {$REPO,$HOME}/.config/ranger/rc.conf
fi
