set encoding=utf-8
scriptencoding utf-8
packloadall
syntax on
"general stuff"
set list
set listchars=eol:⤦
set linebreak
set tabstop=4
set softtabstop=0 
set expandtab
set shiftwidth=4
set backspace=indent,eol,start
set number relativenumber
set autoindent smartindent

nmap <Space> :
inoremap kj <Esc>
"folding stuff"
set foldmethod=indent
set foldlevel=1
set foldnestmax=10
set foldenable

"brackets"
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap \$ $$<left>
inoremap <% <%%><left><left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

