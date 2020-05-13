set nocompatible
set clipboard=unnamed
set wildmenu
set encoding=utf-8
scriptencoding utf-8
packloadall
syntax on

" general stuff
set list
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set linebreak
set tabstop=4
set softtabstop=0 
set expandtab
set shiftwidth=4
set backspace=indent,eol,start
set number relativenumber
set autoindent smartindent
set cursorline
" syntax stuff
syntax on

nmap <Space> :
inoremap kj <Esc>

" folding stuff
set foldmethod=indent
set foldlevel=1
set foldnestmax=10
set foldenable

" brackets
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap \$ $$<left>
inoremap <% <%%><left><left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

