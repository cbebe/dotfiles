vim.cmd  [[packadd packer.nvim]]

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  use 'nvim-treesitter/nvim-treesitter'
  use 'masukomi/vim-markdown-folding'
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-sensible'
  use 'shaunsingh/nord.nvim'
  use 'tyru/open-browser.vim'
  use 'neovim/nvim-lspconfig'
  use 'prabirshrestha/vim-lsp'
  use 'derekwyatt/vim-fswitch'
  use 'ray-x/go.nvim'         -- Go plugin
end)
