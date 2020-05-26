"
" ~/dotfiles/.vimrc
"
let &runtimepath.=",~/dotfiles/.vim"
let $MYVIMRC="~/dotfiles/.vimrc"

set nocompatible
set noswapfile

set background=dark
colorscheme distinguished

set nobackup nowritebackup
set belloff=all " turn off annoying bell sound
set incsearch
set ignorecase
set laststatus=2
set clipboard=unnamed
set ruler
set wildmenu " command auotocompletion
set showcmd
set showcmd
set encoding=utf-8
scriptencoding utf-8
packloadall
syntax on

" general stuff
let mapleader=","
set backspace=2
set list
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set linebreak
set tabstop=4
set shiftwidth=4
set autoindent
set shiftround " rounds the indentation to shiftwidth when shifting
set smarttab
set expandtab
set backspace=indent,eol,start
set number relativenumber
set textwidth=80
set numberwidth=5
set autoindent smartindent
set nojoinspaces " no more pressing spacebar over and over!!
" syntax stuff
syntax on

nmap <Space> :
inoremap kj <Esc>
inoremap KJ <Esc>

" folding stuff
set foldmethod=indent
set foldnestmax=10
set foldenable

" brackets
inoremap " ""<left>
" makes writing vim comments less annoying
inoremap "<space> "<space>

inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap \$ $$<left>
inoremap <% <%%><left><left>
" prevents the lagging thing
inoremap << <<
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O


" lmao
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" make vimrc editing easier
nnoremap <leader>ve :vsplit $MYVIMRC<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>

" running python scripts
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!py' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!py' shellescape(@%, 1)<CR>
