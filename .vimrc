set nocompatible               " be iMproved
set encoding=utf-8             " Unicode support
set laststatus=2
filetype off                   " required!

inoremap jk <ESC>
let mapleader = "\<Space>"

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'Lokaltog/vim-powerline'
Plugin 'rip-rip/clang_complete'
Plugin 'tpope/vim-fugitive'
Plugin 'altercation/vim-colors-solarized'
call vundle#end()

filetype plugin indent on
syntax enable

set background=dark
colorscheme solarized

