"
" ~/dotfiles/nvim/old.vim
" Old .vimrc before I got around to using neovim
"

" Optimize for fast terminal connections
set ttyfast
" Highlight as pattern is typed
set incsearch
" Ignore case in searches
set ignorecase
" Always show status line
set laststatus=2
" Use OS clipboard
set clipboard^=unnamedplus
" Command autocompletion
set wildmenu showcmd

" Use UTF-8 encoding
set encoding=utf-8
scriptencoding utf-8


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

" Shiftwidth takes tabstop's value
set shiftwidth=0
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
    autocmd FileType markdown setlocal tabstop=2
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

hi clear SpellBad
hi SpellBad cterm=underline

set background=dark
colorscheme gruvbox

" Allow syntax higlighting
syntax on
filetype on
