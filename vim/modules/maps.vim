" for easier navigation
nnoremap H 0
nnoremap L $

nnoremap <space><space> :


" Using CocList

" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
inoremap kj <Esc>
inoremap KJ <Esc>

" quotes
inoremap " ""<left>
inoremap ' ''<left>
" makes writing vim comments less annoying
inoremap "<space> "<space>
" surrounding a visual block in quotes
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>`>
vnoremap <leader>' <esc>`>a'<esc>`<i'<esc>`>

" brackets
inoremap ( ()<left>
inoremap [ []<left>
" for functions
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
inoremap \$ $$<left>
inoremap <% <%%><left><left>
" surround stuff
vnoremap <leader>( <esc>`>a)<esc>`<i(<esc>`>
vnoremap <leader>{ <esc>`>a}<esc>`<i{<esc>`>
" prevents the lagging thing
inoremap << <<

" lmao
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" make vimrc editing easier
nnoremap <leader>ve :vsplit $MYVIMRC<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>
nnoremap <leader>vme :vsplit $MODULEPATH/maps.vim<cr>
nnoremap <leader>vpe :vsplit $MODULEPATH/plugins.vim<cr>
nnoremap <leader>vpce :vsplit $MODULEPATH/plugin_config.vim<cr>

" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
