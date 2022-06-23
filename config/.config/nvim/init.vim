set nocompatible

lua require('setup')

let mapleader = " "
let localleader = "\\"

let g:suda_smart_edit = 1

colorscheme base16-default-dark

" Remove trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()

" Single command to remove all trailing whitespaces
nnoremap <silent> <leader>rs :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

function! s:JbzCppMan()
    let old_isk = &iskeyword
    setl iskeyword+=:
    let str = expand("<cword>")
    let &l:iskeyword = old_isk
    execute 'Man ' . str
endfunction
command! JbzCppMan :call s:JbzCppMan()

au FileType cpp nnoremap <buffer>K :JbzCppMan<CR>

" vim-fswitch
nnoremap <silent> <localleader>oo :FSHere<cr>
" Extra hotkeys to open header/source in the split
nnoremap <silent> <localleader>oh :FSSplitLeft<cr>
nnoremap <silent> <localleader>oj :FSSplitBelow<cr>
nnoremap <silent> <localleader>ok :FSSplitAbove<cr>
nnoremap <silent> <localleader>ol :FSSplitRight<cr>

nnoremap <silent> <leader>ve <cmd>e $MYVIMRC<cr>
nnoremap <silent> <leader>vp <cmd>e $XDG_CONFIG_HOME/nvim/lua/plugins.lua<cr>
nnoremap <silent> <leader>vl <cmd>e $XDG_CONFIG_HOME/nvim/lua/setup.lua<cr>
nnoremap <silent> <leader>vn <cmd>e $XDG_CONFIG_HOME/nixpkgs/home.nix<cr>
nnoremap <silent> <leader>vs <cmd>source $MYVIMRC<cr>

" close all buffers except current one
nnoremap <leader>bd :%bd\|e#\|bd#<cr>\|'"

function! s:JbzClangFormat(first, last)
  let l:winview = winsaveview()
  execute a:first . "," . a:last . "!clang-format"
  call winrestview(l:winview)
endfunction
command! -range=% JbzClangFormat call <sid>JbzClangFormat (<line1>, <line2>)

" Autoformatting with clang-format
au FileType c,cpp nnoremap <buffer><leader>lf :<C-u>JbzClangFormat<CR>
au FileType c,cpp vnoremap <buffer><leader>lf :JbzClangFormat<CR>

autocmd FileType markdown set foldexpr=NestedMarkdownFolds()

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END


if has("autocmd")
  filetype plugin indent on
endif


nnoremap Y yg$
nnoremap <leader>x :silent !chmod +x %<CR>

" greatest remap ever
xnoremap <leader>p "_dP

" next greatest remap ever : asbjornHaland
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nmap <leader>Y "+Y

nnoremap <leader>cc gg"+yG
nnoremap <leader>cv ggVG"+p

nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Automatically center search results
nnoremap <silent> n nzz
nnoremap <silent> N Nzz


autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()

set directory=$XDG_CACHE_HOME/vim/swap,~/,/tmp
set backupdir=$XDG_CACHE_HOME/vim/backup,~/,/tmp
set undodir=$XDG_CACHE_HOME/vim/undo,~/,/tmp

