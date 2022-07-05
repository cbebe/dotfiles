local opt, g, set = vim.opt, vim.g, vim.keymap.set

opt.compatible = false

require("setup")

g.mapleader = " "
g.localleader = "\\"

g.shfmt_opt = "-ci"

-- Disable provider warnings
g.loaded_perl_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0

opt.guicursor = ""
opt.number = true
opt.relativenumber = true
opt.hlsearch = false
opt.hidden = true

vim.cmd("colorscheme base16-default-dark")

function SetTab(num, expand)
	opt.tabstop = num
	opt.softtabstop = num
	opt.shiftwidth = num
	opt.expandtab = expand
end

SetTab(2, true)

local function grp(name)
	vim.api.nvim_create_augroup(name, { clear = true })
end

local au = vim.api.nvim_create_autocmd

-- Render extra whitespace
vim.cmd([[
  highlight ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\s\+$/
]])
local w = grp("RenderWhiteSpace")
au("BufWinEnter", { command = [[match ExtraWhitespace /\s\+$/]], group = w })
au("InsertEnter", { command = [[match ExtraWhitespace /\s\+\%#\@<!$/]], group = w })
au("InsertLeave", { command = [[match ExtraWhitespace /\s\+$/]], group = w })
au("BufWinLeave", { command = [[call clearmatches()]], group = w })

-- Highlight on Yank
local yankGrp = grp("YankHighlight")
au("TextYankPost", { command = "lua require'vim.highlight'.on_yank({timeout = 40})", group = yankGrp })

-- Edit with suda
g.suda_smart_edit = 1

g.neoformat_try_node_exe = 1

local opts = { noremap = true, silent = true }

local function removeTrailingWhiteSpace()
	vim.cmd([[
    let _s=@/
    %s/\s\+$//e
    let @/=_s
    nohl
    unlet _s
  ]])
end

local function desc(str)
	return { desc = str, unpack(opts) }
end

local function lset(key, fn, mapOpts)
	set("n", "<leader>" .. key, fn, mapOpts)
end

lset("cd", "<cmd>cd %:p:h<cr>", desc("change current directory to the file in the buffer"))
lset("rs", removeTrailingWhiteSpace, desc("Remove all trailing whitespace"))

local function bindf(bind, file)
	lset(bind, "<cmd>e " .. file .. "<cr>", opts)
end

-- Keybinds for commonly edited config files
bindf("ve", "$MYVIMRC")
bindf("vp", "$XDG_CONFIG_HOME/nvim/lua/plugins.lua")
bindf("vl", "$XDG_CONFIG_HOME/nvim/lua/setup.lua")
bindf("vn", "+/home.packages $XDG_CONFIG_HOME/nixpkgs/home.nix")

-- Hard time to break bad vim habits
lset("h", "<cmd>HardTimeToggle<cr>", opts)
-- Reload config
lset("vs", "<cmd>source $MYVIMRC<cr>", opts)
lset("z", "<cmd>bd<cr>", desc("Close current buffer"))
lset("o", "%O", desc("Insert after the last line in the enclosing brackets"))

local function liveGrep(noHidden)
	return function()
		local args = { "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column" }
		if noHidden then
			table.insert(args, "--ignore-case")
		else
			table.insert(args, "--smart-case")
			table.insert(args, "-u")
		end
		require("telescope.builtin").live_grep({ vimgrep_arguments = args })
	end
end

local function findFiles()
	require("telescope.builtin").find_files({ find_command = { "rg", "--files", "--hidden", "-g", "!.git" } })
end

lset("l", findFiles, desc("Find files with ripgrep"))
lset("F", findFiles, desc("Find files with ripgrep"))
lset("fg", liveGrep(true), desc("Live grep"))
lset("fG", liveGrep(false), desc("Live grep but also look for hidden files"))
lset("fb", "<cmd>Telescope buffers<cr>", opts)
lset("fh", "<cmd>Telescope help_tags<cr>", opts)
lset(".", vim.lsp.buf.code_action, desc("LSP Code action"))
lset("bd", [[<cmd>%bd<bar>e#<bar>bd#<cr><bar>'"]], desc("Close all buffers except current one"))

set("n", "Y", "yg$", desc("Yank analogue of D"))
lset("x", "<cmd>silent !chmod +x %<cr>", desc("Make current file executable"))
lset("X", "<cmd>!./%<cr>", desc("Execute current file"))

set({ "n", "v" }, "<leader>y", '"+y', desc("Yank to clipboard register"))
lset("Y", '"+Y')

lset("c", 'gg"+yG', desc("Yank the entire buffer into the clipboard"))
lset("p", '"+p', desc("Paste clipboard contents"))
lset("cv", 'ggVG"+p', desc("Replace the buffer with clipboard contents"))

if vim.fn.has("autocmd") then
	vim.cmd("filetype plugin indent on")
end

set({ "n", "v" }, "<leader>d", '"_d', desc("Delete to black hole register"))

set("n", "n", "nzz", opts)
set("n", "N", "Nzz", opts)

set("x", "<leader>p", '"_dP', desc("The greatest remap ever"))

lset("e", require("harpoon.ui").toggle_quick_menu, desc("Open Harpoon quick menu"))
lset("tc", require("harpoon.cmd-ui").toggle_quick_menu, desc("Open Harpoon cmd quick menu"))
lset("a", require("harpoon.mark").add_file, desc("Mark file in harpoon"))

local navKeys = { "h", "j", "k", "l" }
for i = 1, #navKeys do
	set("n", "<C-" .. navKeys[i] .. ">", function()
		require("harpoon.ui").nav_file(i)
	end, opts)
end

function MapLuaBindings()
	set("n", "<localleader>r", function()
		require("harpoon.tmux").sendCommand(1, "love .\n")
	end, desc("Run love in current directory"))
	set(
		"n",
		"<localleader>d",
		[[ofunction dump(o)
if type(o) == 'table' then
local s = '{ '
for k,v in pairs(o) do
if type(k) ~= 'number' then k = '"'..k..'"' end
s = s .. '['..k..'] = ' .. dump(v) .. ','
end
return s .. '} '
else
return tostring(o)
end
end]],
		desc("Dump function")
	)
end

local fmtGrp = grp("fmt")
au("BufWritePre", { command = "silent Neoformat", pattern = "*", group = fmtGrp })

local loveGrp = grp("Love2DDev")
au("BufWinEnter", { command = "silent! lua MapLuaBindings()", pattern = "*.lua", group = loveGrp })
au("BufWinEnter", { command = "HardTimeOn" })

lset("s", function()
	require("harpoon.tmux").gotoTerminal(1)
end, desc("Go to terminal 1 inside tmux"))
lset("G", function()
	require("harpoon.tmux").sendCommand(1, "lazygit\n")
end, desc("Open lazygit inside tmux"))

local vimDir = os.getenv("XDG_CACHE_HOME") .. "/vim"
opt.directory = vimDir .. "/swap,~/,/tmp"
opt.backupdir = vimDir .. "/backup,~/,/tmp"
opt.undodir = vimDir .. "/undo,~/,/tmp"

opt.errorbells = false
opt.smartindent = true
opt.incsearch = true
opt.termguicolors = true
opt.scrolloff = 8
-- opt.showmode = false
opt.signcolumn = "yes"
opt.isfname = opt.isfname + "@-@"
-- opt.ls = 0

-- Give more space for displaying messages.
opt.cmdheight = 1
-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
opt.updatetime = 50
-- Don't pass messages to |ins-completion-menu|.
opt.shortmess = opt.shortmess + "c"
opt.colorcolumn = { 72, 80, 100, 120 }
opt.foldlevel = 99
