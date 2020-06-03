"
" ~/dotfiles/nvim/init.vim
"

" Set paths
" reset runtimepath to default to prevent adding ~/dotfiles/nvim over and over
set runtimepath&
let $DOTFILEPATH = "~/dotfiles/nvim"
let &runtimepath .= ",".$DOTFILEPATH
let $MYVIMRC = $DOTFILEPATH."/init.vim"
let $MODULEPATH = $DOTFILEPATH."/modules"

" setting shell to zsh
set shell=/bin/zsh

" typical vim setup stuff
runtime! setup.vim
" load nvim plugins
runtime! plugins.vim
" load other modules
" these are for settings that won't be touched for a long time
runtime! modules/*.vim

" Neovim Mappings
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

" Finding the current file
nnoremap <C-m> :NERDTreeFind<CR>
nnoremap <C-n> :NERDTreeToggle<CR>

