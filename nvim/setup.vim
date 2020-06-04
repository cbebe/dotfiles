" Typical Setup

set number
" words don't break when wrapping
set wrap linebreak
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

" For visually jumping lines
function! JumpVisualLine()
  noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
  noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
endfunction
function! JumpNormalLine()
  unmap j
  unmap k
endfunction

nnoremap <leader>ll :<C-U>exec "normal".JumpVisualLine()<CR>
nnoremap <leader>lk :<C-U>exec "normal".JumpNormalLine()<CR>

" Automatically install plugins
autocmd! VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

