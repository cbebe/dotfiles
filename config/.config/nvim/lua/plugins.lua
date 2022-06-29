local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd  [[packadd packer.nvim]]

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'  }
  use 'theHamsta/nvim-dap-virtual-text'
  use 'masukomi/vim-markdown-folding'
  use 'tpope/vim-sensible'
  use 'sbdchd/neoformat'
  use 'chriskempson/base16-vim'
  use 'tyru/open-browser.vim'
  use 'neovim/nvim-lspconfig'
  use 'prabirshrestha/vim-lsp'
  use 'derekwyatt/vim-fswitch'
  use 'ray-x/go.nvim'         -- Go plugin
  use 'lambdalisue/suda.vim'
  use 'ThePrimeagen/harpoon'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
	use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
	}
  use 'LnL7/vim-nix'
  use {'ray-x/guihua.lua', run = 'cd lua/fzy && make'}
  -- NVIM completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {
        icons = false,
        fold_open = "v", -- icon used for open folds
        fold_closed = ">", -- icon used for closed folds
        indent_lines = false, -- add an indent guide below the fold icons
        signs = {
            -- icons / text used for a diagnostic
            error = "error",
            warning = "warn",
            hint = "hint",
            information = "info"
        },
        use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
      }
    end
  }
  use 'jose-elias-alvarez/nvim-lsp-ts-utils' -- Organize imports
  use 'terrortylor/nvim-comment'

  -- tabular plugin is used to format tables
  use 'godlygeek/tabular'
  -- JSON front matter highlight plugin
  use 'elzr/vim-json'
  use 'plasticboy/vim-markdown'
end)
