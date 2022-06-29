local opt, g, api, set = vim.opt, vim.g, vim.api, vim.keymap.set

opt.compatible = false

require('setup')

g.mapleader = " "
g.localleader = "\\"

-- Disable provider warnings
g.loaded_perl_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0

opt.guicursor = ''
opt.number = true
opt.relativenumber = true
opt.hlsearch = false
opt.hidden = true

vim.cmd("colorscheme base16-default-dark")

local function setTab(num, expand)
  opt.tabstop = num
  opt.softtabstop = num
  opt.shiftwidth = num
  opt.expandtab = expand
end

setTab(2, expand)

local grp = function(name) api.nvim_create_augroup(name, { clear = true }) end
local au = api.nvim_create_autocmd

-- Render extra whitespace
vim.cmd([[
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
]])
local whiteSpaceGrp = grp("RenderWhiteSpace")
au("BufWinEnter", { command=[[match ExtraWhitespace /\s\+$/]],        group=whiteSpaceGrp })
au("InsertEnter", { command=[[match ExtraWhitespace /\s\+\%#\@<!$/]], group=whiteSpaceGrp })
au("InsertLeave", { command=[[match ExtraWhitespace /\s\+$/]],        group=whiteSpaceGrp })
au("BufWinLeave", { command=[[call clearmatches()]],                  group=whiteSpaceGrp })

-- Highlight on Yank
local yankGrp = grp("YankHighlight")
au("TextYankPost", {
  command = "silent! lua require'vim.highlight'.on_yank({timeout = 40})",
  group   = yankGrp
})

-- Edit with suda
g.suda_smart_edit = 1

g.neoformat_try_node_exe = 1

-- Auto-format JS/TS files
local tsFormatGrp = grp("TSFormat")
au("BufWritePre", {
  command = "Neoformat prettier",
  pattern = "*.{ts,tsx,js,jsx}",
  group   = tsFormatGrp
})

local opts = { noremap=true, silent=true }

set('n', '<leader>rs', [[:let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>]], {
  desc = "Remove all trailing whitespace",
  unpack(opts)
})

-- Keybinds for commonly edited config files
set('n', '<leader>ve', '<cmd>e $XDG_CONFIG_HOME/nvim/init.lua<cr>',                              opts)
set('n', '<leader>vp', '<cmd>e $XDG_CONFIG_HOME/nvim/lua/plugins.lua<cr>', opts)
set('n', '<leader>vl', '<cmd>e $XDG_CONFIG_HOME/nvim/lua/setup.lua<cr>',   opts)
set('n', '<leader>vn', '<cmd>e +40 $XDG_CONFIG_HOME/nixpkgs/home.nix<cr>', opts)

-- Reload config
set('n', '<leader>vs', '<cmd>source $XDG_CONFIG_HOME/nvim/init.lua<cr>', opts)

set('n', '<leader>z', '<cmd>bd<cr>', {
  desc = "Close current buffer",
  unpack(opts)
})

set('n', '<leader>o', '%O', {
  desc = "Insert after the last line in the enclosing brackets",
  unpack(opts)
})

local function liveGrep(ignoreCase)
  args = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column' }
  if ignoreCase then table.insert(args, '--ignore-case') end
  require'telescope.builtin'.live_grep{ vimgrep_arguments = args }
end

local function findFiles()
  require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})
end


vim.cmd([[
" telescope
nnoremap <leader>F <cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>
nnoremap <leader>fg <cmd>lua require'telescope.builtin'.live_grep{ vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--ignore-case' } }<cr>
" Also look in hidden files but slower
nnoremap <leader>fG <cmd>lua require'telescope.builtin'.live_grep{ vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '-u' } }<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" code action
nnoremap <leader>. <cmd>lua vim.lsp.buf.code_action()<cr>

" close all buffers except current one
nnoremap <leader>bd :%bd\|e#\|bd#<cr>\|'"

" autocmd FileType markdown set foldexpr=NestedMarkdownFolds()

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
nnoremap <silent><leader>G <cmd>lua require("harpoon.tmux").sendCommand(1, "lazygit\n")<cr>

nnoremap <silent><leader><C-l> <cmd>mode<cr>


autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()

set directory=$XDG_CACHE_HOME/vim/swap,~/,/tmp
set backupdir=$XDG_CACHE_HOME/vim/backup,~/,/tmp
set undodir=$XDG_CACHE_HOME/vim/undo,~/,/tmp

set noerrorbells
set smartindent
set incsearch
set termguicolors
set scrolloff=8
" set noshowmode
set signcolumn=yes
set isfname+=@-@
" set ls=0

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=72,80,100,120
]])

opt.foldlevel=99
