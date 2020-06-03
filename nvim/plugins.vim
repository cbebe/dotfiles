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


