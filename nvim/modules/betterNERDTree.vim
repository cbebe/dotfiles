" Better NERDTree

" Open NERDTree by default and close automatically
augroup NERDTree_autocmds
  autocmd!
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
augroup END
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeShowHidden= 1
" Make NERDTree prettier
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
