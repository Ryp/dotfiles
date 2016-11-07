set nocompatible                      " be iMproved
set encoding=utf-8 nobomb             " Unicode support
set laststatus=2                      " Permanent status bar
set t_Co=256                          " Colors
set shortmess=atI                     " No intro message at start
set title
set number                            " Enable line numbers
set cursorline                        " Highlight current line
set relativenumber                    " Show relative line numbers
set list lcs=tab:▸\ ,trail:·,nbsp:_   " Show invisible characters
set showcmd                           " Show current command
set noerrorbells                      " Disable the bell
set scrolloff=4                       " Start scrolling n lines before the horizontal window border
set nowrap                            " Do not wrap long lines

set tabstop=4                         " Set tab width
set shiftwidth=4                      " Indent size
set smarttab                          " Auto align on the next indent when using tab
set expandtab                         " Insert spaces when pressing tab

set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif

" ConEmu
if !empty($CONEMUBUILD)
    echom "Running in conemu"
    set termencoding=utf8
    set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
    " termcap codes for cursor shape changes on entry and exit to/from insert mode doesn't work
    "let &t_ti="\e[1 q"
    "let &t_SI="\e[5 q"
    "let &t_EI="\e[1 q"
    "let &t_te="\e[0 q"
endif

function! StripWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction

let mapleader = "\<Space>"
inoremap jk <ESC>
nnoremap <SPACE> <Nop>

" Nazi mode (maybe check out VIM Hard Mode)
" Level 1: do not allow arrow keys
inoremap  <Up>     <Nop>
inoremap  <Down>   <Nop>
inoremap  <Left>   <Nop>
inoremap  <Right>  <Nop>

vnoremap  <Up>     <Nop>
vnoremap  <Down>   <Nop>
vnoremap  <Left>   <Nop>
vnoremap  <Right>  <Nop>

" Level 2: even in insert mode
noremap   <Up>     <Nop>
noremap   <Down>   <Nop>
noremap   <Left>   <Nop>
noremap   <Right>  <Nop>

" Level 3: do not allow hjkl to move around in normal mode
" noremap h <Nop>
" noremap j <Nop>
" noremap k <Nop>
" noremap l <Nop>

noremap <leader>W :w !sudo tee % > /dev/null<CR>    " Save file as root

filetype off                          " required for vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Lokaltog/powerline-fonts'
" Plugin 'rip-rip/clang_complete'
Plugin 'justmao945/vim-clang'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'zeux/qgrep'
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
let g:airline#extensions#tabline#enabled = 1 " Show buffer bar

" For vim-clang
let g:clang_compilation_database = './build'
let g:clang_cpp_options = '-std=c++14'

