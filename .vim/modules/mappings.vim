" For easier navigation
nnoremap H 0
nnoremap L $

" Easier escape
inoremap kj <Esc>

" surrounding a visual block in quotes
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>`>
vnoremap <leader>' <esc>`>a'<esc>`<i'<esc>`>

" brackets
inoremap ( ()<left>
inoremap [ []<left>

inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" LaTeX math brackets
inoremap \$ $$<left>
" ejs brackets
inoremap <% <%%><left><left>
" prevents the lagging thing
inoremap << <<

" make vimrc editing easier
nnoremap <leader>ve :vsplit $MYVIMRC<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>
nnoremap <leader>vme :vsplit $MODULEPATH/maps.vim<cr>
nnoremap <leader>vpe :vsplit $MODULEPATH/plugins.vim<cr>
nnoremap <leader>vpce :vsplit $MODULEPATH/plugin_config.vim<cr>

" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Spellchecker
nnoremap <leader>ct :setlocal spell! spelllang=en_us<cr>

