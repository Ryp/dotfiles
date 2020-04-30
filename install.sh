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

REPO=$(dirname $(readlink -f "$0"))

echo 'Installing from' $REPO

link_file {$REPO,$HOME}/.gitconfig
link_file {$REPO,$HOME}/.gdbinit

if confirm "Install custom scripts?"
then
    mkdir -p $HOME/.local/bin
    link_file {$REPO,$HOME/.local}/bin/ipodsync
    link_file {$REPO,$HOME/.local}/bin/set_wallpaper
fi

# htop Setup
mkdir -p $HOME/.config/htop
link_file {$REPO,$HOME}/.config/htop/htoprc

link_file {$REPO,$HOME}/.profile
link_file {$REPO,$HOME}/.aliases
link_file {$REPO,$HOME}/.dircolors
link_file {$REPO,$HOME}/.config/user-dirs.dirs

if confirm "Install bash cfg?"
then
    link_file {$REPO,$HOME}/.bashrc
    link_file {$REPO,$HOME}/.bash_profile
fi

if confirm "Install zsh cfg?"
then
    link_file {$REPO,$HOME}/.zshrc
    wget -O $HOME/.zshrc_grml http://git.grml.org/f/grml-etc-core/etc/zsh/zshrc
    link_file {$REPO,$HOME}/.zlogin
fi

if confirm "Install vim cfg?"
then
    link_folder $REPO/.vim $HOME
    link_file {$REPO,$HOME}/.vimrc
    mkdir -p $HOME/.vim/{backup,swap,undo,cache,autoload}
    cp $REPO/{external/vim-plug/plug.vim,.vim/autoload}

    vim +PlugInstall +qall

    if confirm "Vim plugins post-install?"
    then
        # Install powerline patched fonts
        $HOME/.vim/bundle/powerline-fonts/install.sh
        # Setup YCM
        # requires some libs first, check the help (:h Ycm)
        $HOME/.vim/bundle/YouCompleteMe/install.py --clang-completer --racer-completer

        rust_source_archive="1.36.0.tar.gz"
        rust_source_path="$HOME/.vim/cache"
        wget -nc -P $rust_source_path "https://github.com/rust-lang/rust/archive/$rust_source_archive"
        tar -zxvf "$rust_source_path/$rust_source_archive" -C $rust_source_path
    fi
fi

if confirm "Install sway cfg?"
then
    mkdir -p $HOME/.config/sway
    link_file {$REPO,$HOME}/.config/sway/config

    mkdir -p $HOME/.config/i3status
    link_file {$REPO,$HOME}/.config/i3status/config

    link_folder $REPO/.Xresources.d $HOME
    link_file {$REPO,$HOME}/.Xresources
fi

if confirm "Install ranger cfg?"
then
    mkdir -p $HOME/.config/ranger
    link_folder $REPO/.config/ranger/colorschemes $HOME/.config/ranger
    link_file {$REPO,$HOME}/.config/ranger/rc.conf
fi

if confirm "Install cmus cfg?"
then
    mkdir -p $HOME/.config/cmus
    link_file {$REPO,$HOME}/.config/cmus/rc
fi

if confirm "Install tmux cfg?"
then
    link_file {$REPO,$HOME}/.tmux.conf
    link_folder $REPO/.tmux $HOME
fi

if confirm "Install weechat cfg?"
then
    mkdir -p $HOME/.weechat
    link_file {$REPO,$HOME}/.weechat/irc.conf
    link_file {$REPO,$HOME}/.weechat/plugins.conf
    link_file {$REPO,$HOME}/.weechat/script.conf
    link_file {$REPO,$HOME}/.weechat/weechat.conf

    if confirm "Reset sec.conf?"
    then
        echo -n 'New passphrase:'
        read -s WEECHAT_PASSPHRASE
        echo
        echo -n 'Freenode password:'
        read -s FREENODE_PASSWORD
        echo
        weechat -r "/secure passphrase $WEECHAT_PASSPHRASE ; /secure set freenode_password $FREENODE_PASSWORD ; /quit"
        cat $HOME/.weechat/sec.conf
    fi
fi

if confirm "Install rtorrent cfg?"
then
    # Config path
    mkdir -p $HOME/.config/rtorrent
    link_file {$REPO,$HOME}/.rtorrent.rc

    # Local folders
    mkdir -p $HOME/.local/share/rtorrent/{download,session,log}
fi

if confirm "Install alacritty cfg?"
then
    # Config path
    link_file {$REPO,$HOME}/.alacritty.yml
fi

echo 'done'

