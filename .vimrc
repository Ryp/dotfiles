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
set modelines=0                       " Disable modelines (i don't use them and they are not secure)

set tabstop=4                         " Set tab width
set shiftwidth=4                      " Indent size
set smarttab                          " Auto align on the next indent when using tab
set expandtab                         " Insert spaces when pressing tab
set backspace=2                       " Relaxed rules for backspace in insert mode

set backupdir=~/.vim/backup
set directory=~/.vim/swap
if exists("&undodir")
    set undofile                      " Enable persistent undo history
    set undodir=~/.vim/undo           " Specify undo history folder
endif

set exrc                              " Allow vim to source project-specific vimrc's
set secure                            " Do not allow unsafe commands when sourcing these

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

" Use the space key as leader
let mapleader = "\<Space>"
nnoremap <SPACE> <Nop>

" Go from insert to normal mode with jk instead of ESC
inoremap jk <ESC>

" Buffer management
set hidden                            " Allow switching buffers without writing to the current one
nmap <leader>T :enew<cr>
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

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

Plugin 'scrooloose/nerdtree'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
" Plugin 'rip-rip/clang_complete'
Plugin 'justmao945/vim-clang'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'vhdirk/vim-cmake' " CMake integration
" Plugin 'zeux/qgrep'
" Plugin 'jalcine/cmake.vim' " CMake integration
Plugin 'SirVer/ultisnips'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Lokaltog/powerline-fonts'
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
let g:airline#extensions#tabline#fnamemod = ':t' " Only show filename
let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'v'  : 'V',
  \ 'V'  : 'V',
  \ '' : 'V',
  \ 's'  : 'S',
  \ 'S'  : 'S',
  \ '' : 'S',
  \ }

" For vim-clang
let g:clang_compilation_database = './build'
let g:clang_cpp_options = '-std=c++14'

" Make CtrlP more accessible
nmap <leader>p :CtrlP<cr>

" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn))$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
  \ }

" Show hidden files by default
let g:ctrlp_show_hidden = 1

" Use the nearest .git directory as the cwd
let g:ctrlp_working_path_mode = 'r'

" Configure UltiSnips
" let g:UltiSnipsExpandTrigger="<c-s>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"

