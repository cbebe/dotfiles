"                   __ _             _           
"   ___ ___  _ __  / _(_) __ ___   _(_)_ __ ___  
"  / __/ _ \| '_ \| |_| |/ _` \ \ / / | '_ ` _ \ 
" | (_| (_) | | | |  _| | (_| |\ V /| | | | | | |
"  \___\___/|_| |_|_| |_|\__, (_)_/ |_|_| |_| |_|
"                        |___/                   
"
" Charles Ancheta's vim configuration

" make vim kewl
set nocompatible

" get plugins
call plug#begin('~/.vim/plugged')

Plug 'junegunn/seoul256.vim'

call plug#end()

let g:seoul256_background = 233
colorscheme seoul256
" Dark background
set background=dark

" Enable true color
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors 
endif

" enable syntax highlighting
syntax on

" backspace does what it's supposed to do
set backspace=indent,eol,start

" open horizontal splits on the right and vertical splits on the bottom
set splitbelow splitright

" lines don't break in between words
set nowrap breakindent linebreak nolist

" display column number in status line
set ruler

" always show status line
set laststatus=2

" get a single mode line from a file
set modelines=1

" turn off annoying visual bell
set visualbell
set t_vb=

" show line numbers
set number

set scrolloff=10 sidescrolloff=10
set mouse=i
set ttyfast

set wildmenu wildmode=list:full

" find words as you type
set incsearch smartcase hlsearch
set gdefault

" default tab width is 2
set shiftwidth=0
set tabstop=2 softtabstop=2
" expands tabs into spaces
set expandtab
set smartindent autoindent

" set syntax highlighting for gitconfig
autocmd! BufReadPost gitconfig set syntax=gitconfig

inoremap kj <Esc>
                                
