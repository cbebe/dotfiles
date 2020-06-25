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
" make vim kewl
set nocompatible
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

inoremap kj <Esc>
                                
