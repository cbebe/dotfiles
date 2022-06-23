vim.cmd  [[packadd packer.nvim]]

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'  }
  use 'theHamsta/nvim-dap-virtual-text'
  use 'masukomi/vim-markdown-folding'
  use 'wbthomason/packer.nvim'
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
  use 'LnL7/vim-nix'
  use {'ray-x/guihua.lua', run = 'cd lua/fzy && make'}
end)
