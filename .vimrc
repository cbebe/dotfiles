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
set number
set numberwidth=5
set autoindent smartindent
set nojoinspaces " no more pressing spacebar over and over!!
" syntax stuff
syntax on

" for easier navigation
nnoremap H 0
nnoremap L $

nnoremap <Space> :
inoremap kj <Esc>
inoremap KJ <Esc>

" folding stuff
set foldmethod=indent
set foldnestmax=10
set foldenable

" quotes
inoremap " ""<left>
inoremap ' ''<left>
" makes writing vim comments less annoying
inoremap "<space> "<space>
" surrounding a visual block in quotes
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>`>
vnoremap <leader>' <esc>`>a'<esc>`<i'<esc>`>



" brackets
inoremap ( ()<left>
inoremap [ []<left>
" for functions
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
inoremap \$ $$<left>
inoremap <% <%%><left><left>
" surround stuff
vnoremap <leader>( <esc>`>a)<esc>`<i(<esc>`>
vnoremap <leader>{ <esc>`>a}<esc>`<i{<esc>`>
" prevents the lagging thing
inoremap << <<

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

" style guidelines lmao
autocmd FileType javascript set textwidth=80

" for repeating chars
function! RepeatChar(char, count)
  return repeat(a:char, a:count)
endfunction
nnoremap s :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
nnoremap S :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>
