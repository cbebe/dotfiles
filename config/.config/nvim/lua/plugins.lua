local fn = vim.fn
local api = vim.api
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
end

vim.cmd([[packadd packer.nvim]])

local packerGrp = api.nvim_create_augroup("packer_user_config", { clear = true })
api.nvim_create_autocmd("BufWritePost", {
	pattern = "plugins.lua",
	command = "source <afile> | PackerCompile",
	group = packerGrp,
})

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("theHamsta/nvim-dap-virtual-text")
	use("masukomi/vim-markdown-folding")
	use("folke/lua-dev.nvim")
	use({ "ckipp01/stylua-nvim", run = "cargo install stylua" })
	use("tpope/vim-sensible")
	use("sbdchd/neoformat")
	use("chriskempson/base16-vim")
	use("airblade/vim-gitgutter")
	use("tyru/open-browser.vim")
	use("neovim/nvim-lspconfig")
	use("prabirshrestha/vim-lsp")
	-- Go plugin
	use("ray-x/go.nvim")
	use("lambdalisue/suda.vim")
	use("ThePrimeagen/harpoon")
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use("LnL7/vim-nix")
	use({ "ray-x/guihua.lua", run = "cd lua/fzy && make" })
	require("completion")(use)
	use({
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({
				icons = false,
				fold_open = "v", -- icon used for open folds
				fold_closed = ">", -- icon used for closed folds
				indent_lines = false, -- add an indent guide below the fold icons
				signs = {
					-- icons / text used for a diagnostic
					error = "error",
					warning = "warn",
					hint = "hint",
					information = "info",
				},
				-- enabling this will use the signs defined in your lsp client
				use_diagnostic_signs = false,
			})
		end,
	})
	use("jose-elias-alvarez/nvim-lsp-ts-utils") -- Organize imports
	use("terrortylor/nvim-comment")

	-- tabular plugin is used to format tables
	use("godlygeek/tabular")
	-- JSON front matter highlight plugin
	use("elzr/vim-json")
	use("takac/vim-hardtime")

	use("MunifTanjim/eslint.nvim")
	use("rescript-lang/vim-rescript")
end)
