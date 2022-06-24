set nocompatible

lua require('setup')

let mapleader = " "
let localleader = "\\"

" Disable provider warnings
let g:loaded_perl_provider = 0
let g:loaded_python3_provider = 0
let g:loaded_ruby_provider = 0

let g:suda_smart_edit = 1
let g:neoformat_try_node_exe = 1

colorscheme base16-default-dark

" Remove trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()

au BufWritePre *.{ts,tsx,js,jsx} Neoformat prettier

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
nnoremap <silent> <leader>vn <cmd>e +40 $XDG_CONFIG_HOME/nixpkgs/home.nix<cr>
nnoremap <silent> <leader>vs <cmd>source $MYVIMRC<cr>

nnoremap <silent> <leader>o %O

" telescope
nnoremap <leader>F <cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" code action
nnoremap <leader>. <cmd>lua vim.lsp.buf.code_action()<cr>

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

" Harpoon
nnoremap <silent><leader>e :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <silent><leader>tc :lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>
nnoremap <silent><leader>a :lua require("harpoon.mark").add_file()<CR>

nnoremap <silent><C-h> <cmd>lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <silent><C-j> <cmd>lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <silent><C-k> <cmd>lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <silent><C-l> <cmd>lua require("harpoon.ui").nav_file(4)<CR>

nnoremap <silent><leader>s <cmd>lua require("harpoon.tmux").gotoTerminal(1)<cr>
nnoremap <silent><leader>G <cmd>lua require("harpoon.tmux").sendCommand(2, "lazygit\n")<cr>

nnoremap <silent><leader><C-l> <cmd>mode<cr>


autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()

set directory=$XDG_CACHE_HOME/vim/swap,~/,/tmp
set backupdir=$XDG_CACHE_HOME/vim/backup,~/,/tmp
set undodir=$XDG_CACHE_HOME/vim/undo,~/,/tmp

