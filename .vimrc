set nocompatible                      " be iMproved
filetype off                          " required for vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Main plugins
Plugin 'scrooloose/nerdtree'                " Handy tree explorer
Plugin 'tpope/vim-unimpaired'               " Additionnal pair mappings
Plugin 'tpope/vim-fugitive'                 " Git integration
Plugin 'tpope/vim-rhubarb'                  " + support for GitHub
Plugin 'shumphrey/fugitive-gitlab.vim'      " + support for GitLab
Plugin 'airblade/vim-gitgutter'             " Extra column for git +/- signs
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'SirVer/ultisnips'                   " Snippet support (not working yet)
Plugin 'Valloric/YouCompleteMe'             " Clang-based completion
Plugin 'ctrlpvim/ctrlp.vim'                 " Fuzzy file search
Plugin 'mileszs/ack.vim'
Plugin 'vhdirk/vim-cmake'                   " CMake integration
Plugin 'vim-utils/vim-man'                  " Better manual integration

" Cosmetic plugins
Plugin 'altercation/vim-colors-solarized'   " Solarized colors
Plugin 'vim-airline/vim-airline'            " Main theming plugin
Plugin 'vim-airline/vim-airline-themes'     " Extra themes
Plugin 'Lokaltog/powerline-fonts'           " Fancy fonts
Plugin 'edkolev/tmuxline.vim'               " Apply VIM's theme to tmux

" Extra syntax support
Plugin 'pboettch/vim-cmake-syntax'          " CMake
Plugin 'beyondmarc/hlsl.vim'                " HLSL
Plugin 'vim-scripts/supp.vim'               " Valgrind suppression files
Plugin 'dummyunit/vim-fastbuild'            " FASTBuild
call vundle#end()
filetype plugin indent on

syntax enable

set background=dark
colorscheme solarized

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
set belloff=all                       " Disable the bell
set scrolloff=4                       " Start scrolling n lines before the horizontal window border
set nowrap                            " Do not wrap long lines
set modelines=0                       " Disable modelines (i don't use them and they are not secure)
set incsearch                         " Start searching while typing string
set hlsearch                          " Highlight current search
set foldopen-=search                  " Do not expand folds when searching

set tabstop=4                         " Set tab width
set shiftwidth=4                      " Indent size
set smarttab                          " Auto align on the next indent when using tab
set expandtab                         " Insert spaces when pressing tab
set backspace=2                       " Relaxed rules for backspace in insert mode

set hidden                            " Allow switching buffers without writing to the current one

set backupdir=~/.vim/backup
set directory=~/.vim/swap
if exists("&undodir")
    set undofile                      " Enable persistent undo history
    set undodir=~/.vim/undo           " Specify undo history folder
endif

set exrc                              " Allow vim to source project-specific vimrc's
set secure                            " Do not allow unsafe commands when sourcing these

set shortmess+=c                      " Hide default completion messages (interacts with Ycm)

" Key remapping stuff
" In case of conflict, remember this old trick to reveal ambiguous keystrokes:
" :verbose noremap [key_sequence]

" Go from insert to normal mode with jk instead of ESC
inoremap jk <ESC>

" Remap command key (easier to reach)
nnoremap ; :

" Fallback for ; that we just remapped
nnoremap <Bslash> @:

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

" Build shortcut
" map <F5> :make<CR><C-w><Up>
map <F5> :make<CR>

let g:runprg ='./build/reaper && chromium profile.html'

function! MakeRun()
    silent make
    execute '!' . g:runprg
endfunction

map <F6> :call MakeRun()<CR>

" Simple function to strip trailing whitespaces
function! StripWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction

" Same as StripWhitespace but does a retab too
function! CleanFile()
    retab
    call StripWhitespace()
endfunction

" Use the space key as leader
let mapleader = "\<Space>"
nnoremap <Space> <Nop>

nmap <leader>C :call CleanFile()<CR>

" Buffer management
nmap <leader>T :enew<CR>
nmap <leader>j :bprevious<CR>
nmap <leader>k :bnext<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bc :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Manage edits to this file
nnoremap <silent> <leader>ve :e $MYVIMRC<CR>
nnoremap <silent> <leader>vr :so $MYVIMRC<CR>

" My todo/done list
nnoremap <silent> <leader>vt :e $HOME/.mylog<CR>

" Save file as root
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Open file browser
nmap <silent> <leader>r :!ranger<CR>

" Use clang-format on current source file
nmap <leader>cf :!clang-format -style=file -i %<CR>

" Plugin configuration

" vim-fugitive
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gt :Gcommit -v -q %:p<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :silent! Glog<CR>:bot copen<CR>

nnoremap <leader>gp :Ggrep<Space>
" nnoremap <leader>gm :Gmove<Space> (clash)
" nnoremap <leader>gb :Git branch<Space> (clash)
nnoremap <leader>go :Git checkout<Space>

" nnoremap <leader>gps :Dispatch! git push<CR>
" nnoremap <leader>gpl :Dispatch! git pull<CR>

" Do not open countless buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" GitHub support (vim-rhubarb)
let g:github_enterprise_urls = []

" GitLab support (fugitive-gitlab)
let g:fugitive_gitlab_domains = []

" Theme configuration
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

" Make CtrlP more accessible
nmap <leader>p :CtrlP<cr>
nmap <leader>m :CtrlPMRUFiles<cr>

" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn))$',
  \ 'file': '\v\.(exe|so|dll|pdb|obj|png)$',
  \ }

let g:ctrlp_show_hidden = 1                             " Show hidden files by default
let g:ctrlp_working_path_mode = 'r'                     " Use the nearest .git directory as the cwd
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'         " Set cache folder
let g:ctrlp_max_files = 0                               " Unset max file limit
let g:ctrlp_clear_cache_on_exit = 0                     " Enable permanent cache

if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor                " Use ag over grep
    " let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    " let g:ackprg = 'ag --nogroup --nocolor --column'
    let g:ackprg = 'ag --vimgrep'
endif

let g:ackhighlight = 1

" Search
nmap <leader>a :Ack<Space>

" Search word
nmap <leader>sw :Ack <cword><CR>

" Search entire word
nmap <leader>sew :Ack -w <cword><CR>

" vim-man configuration
" Open man (needs a bit of work)
nmap <leader>gm :Vman<Space>

" Configure UltiSnips
" let g:UltiSnipsSnippetDirectories = $HOME . '/.vim/ultisnips'
let g:UltiSnipsSnippetsDir = $HOME . '/.vim/ultisnips'
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-k>"
let g:UltiSnipsJumpBackwardTrigger = "<c-l>"
let g:UltiSnipsListSnippets = "<c-y>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsUsePythonVersion = 2

" YouCompleteMe
let g:ycm_confirm_extra_conf = 0
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_server_log_level = 'debug'

" Reuse hlsl highlighting for cg files
autocmd BufNewFile,BufRead *.cg set ft=hlsl
autocmd BufNewFile,BufRead *.supp set ft=supp

" Set default makeprg for some filetypes
autocmd FileType python set makeprg=pylint\ --reports=n\ --msg-template=\"{path}:{line}:\ {msg_id}\ {symbol},\ {obj}\ {msg}\"\ %
