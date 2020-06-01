"
" ~/dotfiles/nvim/init.vim
"

" Set paths
" reset runtimepath to default to prevent adding ~/dotfiles/nvim over and over
set runtimepath&
let &runtimepath.=",~/dotfiles/nvim"
let $MYVIMRC = "~/dotfiles/nvim/init.vim"
let $MODULEPATH = "~/dotfiles/nvim/modules"

set shell=/bin/bash
let $BASH_ENV = "~/dotfiles/.bash_aliases"

runtime! setup.vim
runtime! modules/*.vim


" nvim doesn't like autoloading >:(
runtime! plug.vim

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" disable startup warning
let g:coc_disable_startup_warning = 1

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plug 'scrooloose/nerdcommenter'

Plug 'christoomey/vim-tmux-navigator'

Plug 'morhetz/gruvbox'

Plug 'HerringtonDarkholme/yats.vim' " TS Syntax

" Initialize plugin system
call plug#end()

" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" ctrlp
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

inoremap kj <ESC>
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

" For easier navigation
nnoremap H 0
nnoremap L $
vnoremap H 0
vnoremap L $


" make vimrc editing easier
nnoremap <leader>ve :vsplit $MYVIMRC<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>
nnoremap <leader>se :vsplit ~/dotfiles/nvim/setup.vim<cr>

" Spellchecker
nnoremap <leader>ct :setlocal spell! spelllang=en_us<cr>

colorscheme gruvbox

" Better NERDTree

" Open NERDTree by default and close automatically
augroup NERDTree_autocmds
  autocmd!
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
augroup END

" Finding the current file
nnoremap <C-n> :NERDTreeToggle<CR>

let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
