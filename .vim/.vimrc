"
" ~/dotfiles/.vim/.vimrc
"

" Set paths
" reset runtimepath to default to prevent adding ~/dotfiles/.vim over and over
set runtimepath&
let &runtimepath.=",~/dotfiles/.vim"
let $MYVIMRC = "~/dotfiles/.vim/.vimrc"
let $MODULEPATH = "~/dotfiles/.vim/modules"

" Expand my bash aliases in vim command line
let $BASH_ENV = "~/dotfiles/.bash_aliases"

" Make vim more useful
set nocompatible
" Optimize for fast terminal connections
set ttyfast
" Enable mouse in all modes
set mouse=a
" turn off annoying bell sound
set belloff=all 
" Highlight as pattern is typed
set incsearch
" Ignore case in searches
set ignorecase
" Always show status line
set laststatus=2
" Use OS clipboard
set clipboard=unnamed
" Command autocompletion
set wildmenu showcmd

" Use UTF-8 encoding
set encoding=utf-8
scriptencoding utf-8

" Allow syntax higlighting
syntax on
filetype on

" folding stuff
set foldmethod=syntax
set foldnestmax=10
set foldenable

" sorry f/F and t/T :(
let mapleader=','
let maplocalleader=';'

" make whitespace visible
set list
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_

" Make line wrapping
set wrap linebreak

" Shifts lines by this much
set shiftwidth=4
" Rounds the indentation to shiftwidth when shifting
set shiftround 
" Fix tabs
set tabstop=4
set autoindent smartindent
set smarttab expandtab

" make backspace work
set backspace=indent,eol,start
set number
set numberwidth=5


" Running python scripts
augroup run_python
    autocmd!
    autocmd FileType python map <buffer> <F9> :w<CR>:exec '!py' shellescape(@%, 1)<CR>
    autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!py' shellescape(@%, 1)<CR>
augroup END

" Style guidelines lmao
augroup style
    autocmd!
    autocmd FileType javascript setlocal textwidth=80
    autocmd FileType vim setlocal formatoptions=cr
augroup END

" To recognize filetype
augroup file_type
    autocmd!
    autocmd BufNewFile,BufRead bash* set syntax=bash
    autocmd BufNewFile,BufRead *gitconfig set syntax=gitconfig
augroup END

" For repeating chars
function! RepeatChar(char, count)
  return repeat(a:char, a:count)
endfunction
nnoremap s :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
nnoremap S :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>

" Import other vim configs
runtime! modules/*.vim

" Automatically install plugins
autocmd! VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

set background=dark
colorscheme gruvbox
