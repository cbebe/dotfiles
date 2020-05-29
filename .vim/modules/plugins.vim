"
" ~/dotfiles/.vim/modules/plugins.vim
"
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }


call plug#end()
