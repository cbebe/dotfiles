"          _                    
"   __   _(_)_ __ ___  _ __ ___ 
"   \ \ / / | '_ ` _ \| '__/ __|
"  _ \ V /| | | | | | | | | (__ 
" (_) \_/ |_|_| |_| |_|_|  \___|
"
" Charles Ancheta's vimrc (WORK IN PROGRESS)


set termguicolors background=dark
" enable syntax highlighting
syntax on
" backspace does what it's supposed to do
set backspace=indent,eol,start
" open horizontal splits on the right and vertical splits on the bottom
set splitbelow splitright
" Make vim kewl
set nocompatible
" Lines don't break in between words
set nowrap breakindent linebreak nolist
set ruler
set laststatus=2
set modelines=1
set visualbell
set t_vb=

set scrolloff=10 sidescrolloff=10
set mouse=i
set ttyfast

set wildmenu wildmode=list:full

set incsearch smartcase hlsearch
set gdefault

" default tab width is 2
set shiftwidth=0
set tabstop=2 softtabstop=2
" expands tabs into spaces
set expandtab
set smartindent autoindent

inoremap kj <Esc>
                                
