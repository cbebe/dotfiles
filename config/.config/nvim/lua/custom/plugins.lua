local function plugins(use)
  use {
    "lambdalisue/suda.vim",
    config = function()
      vim.g.suda_smart_edit = 1
    end,
  }
  use {
    "sbdchd/neoformat",
    config = function()
      -- Use deno for formatting
      vim.g.neoformat_enabled_typescript = { "denofmt" }
      vim.g.neoformat_enabled_typescriptreact = { "denofmt" }
      vim.g.neoformat_enabled_javascript = { "denofmt" }
      vim.g.neoformat_enabled_javascriptreact = { "denofmt" }
      vim.g.neoformat_enabled_markdown = { "denofmt" }
      vim.g.neoformat_enabled_json = { "denofmt" }
    end,
  }
  use "ThePrimeagen/vim-be-good"
  use "nkrkv/nvim-treesitter-rescript"
  use "nvim-treesitter/nvim-treesitter-angular"
  use "LhKipp/nvim-nu"
  use {
    "APZelos/blamer.nvim",
    config = function()
      vim.g.blamer_delay = 500
    end,
  }
  use "ggandor/leap.nvim"
  use "dstein64/vim-startuptime"
  use "opdavies/toggle-checkbox.nvim"
  use "lewis6991/hover.nvim"
  use 'lewis6991/impatient.nvim'
end

return plugins
