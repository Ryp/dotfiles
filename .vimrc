set nocompatible               " be iMproved
set encoding=utf-8             " Unicode support
set laststatus=2               " Permanent status bar
set t_Co=256                   " Colors
filetype off                   " required!

inoremap jk <ESC>
nnoremap <SPACE> <Nop>
let mapleader = "\<Space>"

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Lokaltog/powerline-fonts'
Plugin 'rip-rip/clang_complete'
Plugin 'tpope/vim-fugitive'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'altercation/vim-colors-solarized'
call vundle#end()

filetype plugin indent on
syntax enable

set background=dark
colorscheme solarized

let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.maxlinenr = ''
let g:airline_theme="base16"
