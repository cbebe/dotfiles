"
" ~/dotfiles/.vim/modules/plugins.vim
"
call plug#begin('~/.vim/plugged')

" VSC-like autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Easier comments on files
Plug 'preservim/nerdcommenter'
" Better file explorer
Plug 'preservim/nerdtree'
" Easier brackets
Plug 'tpope/vim-surround'
" Cool theme
Plug 'morhetz/gruvbox'
" Shows git changes on files
Plug 'airblade/vim-gitgutter'
" File formatting
Plug 'prettier/vim-prettier', { 'do': 'npm install' }

call plug#end()
