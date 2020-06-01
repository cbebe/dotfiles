" Typical Setup

set number
" c-style indent
set cindent smartindent
" Shiftwidth takes tabstop's value
set shiftwidth=0
set tabstop=2
" always uses spaces instead of tab characters
set expandtab smarttab
" make whitespace visible
set list
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_
" for text search
set ignorecase

" wider gutter
set numberwidth=5
 
" sorry f/F and t/T :(
let mapleader=','
let maplocalleader=';'

" For repeating chars
function! RepeatChar(char, count)
  return repeat(a:char, a:count)
endfunction
nnoremap s :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
nnoremap S :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>

" Automatically install plugins
autocmd! VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

