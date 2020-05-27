" for easier navigation
nnoremap H 0
nnoremap L $

nnoremap <space> :
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
nnoremap <leader>vme :vsplit modules/maps.vim<cr>
nnoremap <leader>vpe :vsplit modules/plugins.vim<cr>


