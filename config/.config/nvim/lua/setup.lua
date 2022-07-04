require'plugins'

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- local opts = { noremap=true, silent=true }
-- local set = vim.keymap.set
-- set('n', '<space>e', vim.diagnostic.open_float, opts)
-- set('n', '[d',       vim.diagnostic.goto_prev, opts)
-- set('n', ']d',       vim.diagnostic.goto_next, opts)
-- set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  local set = vim.keymap.set
  local buf = vim.lsp.buf
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  set('n', 'gD',        buf.references, bufopts)
  set('n', 'gd',        buf.definition, bufopts)
  set('n', 'K',         buf.hover, bufopts)
  set('n', 'gi',        buf.implementation, bufopts)
-- set('n', '<C-k>',     buf.signature_help, bufopts)
  set('n', '<space>wa', buf.add_workspace_folder, bufopts)
  set('n', '<space>wr', buf.remove_workspace_folder, bufopts)
  set('n', '<space>D',  buf.type_definition, bufopts)
  set('n', '<space>rn', buf.rename, bufopts)
  set('n', '<space>ca', buf.code_action, bufopts)
  set('n', '<space>f',  buf.formatting, bufopts)
  set('n', '<space>wl', function()
    print(vim.inspect(buf.list_workspace_folders()))
  end, bufopts)
end

require'nvim-treesitter.configs'.setup {
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true }
}


local cmp = require'cmp'

vim.api.nvim_command('set completeopt=menu,menuone,noselect')

-- NVIM-CMP Setup
cmp.setup({
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] =     cmp.mapping.scroll_docs(-4),
    ['<C-f>'] =     cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] =     cmp.mapping.abort(),
    -- Accept currently selected item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] =     cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  }),
})

local lspconfig = require'lspconfig'
 --Setup lspconfig.
local capabilities = require('cmp_nvim_lsp')
  .update_capabilities(vim.lsp.protocol.make_client_capabilities())
local opts = { on_attach = on_attach, capabilities = capabilities }

lspconfig.tsserver.setup(opts)
lspconfig.gopls.setup(opts)

require'nvim-dap-virtual-text'.setup{}
require'go'.setup{}
require'nvim_comment'.setup{}

-- lua language server
local sumneko_binary = vim.fn.getenv 'HOME' .. '/.nix-profile/bin/lua-language-server'
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local luadev = require('lua-dev').setup{
  runtime_path = true,
  lspconfig = {
    cmd = { sumneko_binary },
    commands = {
      Format = {
        function()
          require('stylua-nvim').format_file()
        end,
      },
    },
    on_attach = on_attach,
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT', path = runtime_path },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            vim.api.nvim_get_runtime_file('', true),
          },
        },
        telemetry = { enable = false },
      },
    },
  },
}

lspconfig.sumneko_lua.setup(luadev)

local null_ls = require('null-ls')
local eslint = require('eslint')

null_ls.setup()
eslint.setup({
  bin = 'eslint', -- or `eslint_d`
  code_actions = {
    enable = true,
    apply_on_save = {
      enable = true,
      types = { "problem" }, -- "directive", "problem", "suggestion", "layout"
    },
    disable_rule_comment = {
      enable = true,
      location = "separate_line", -- or `same_line`
    },
  },
  diagnostics = {
    enable = true,
    report_unused_disable_directives = false,
    run_on = "type", -- or `save`
  },
})
