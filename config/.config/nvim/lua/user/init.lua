require 'nvim-treesitter.install'.compilers = { "gcc" }

local config = {
    updater = {
      -- get nightly updates
      channel = "nightly",
      -- disable automatically reloading AstroNvim after an update
      auto_reload = false,
      -- disable automatically quitting AstroNvim after an update
      auto_quit = false,
    },
    diagnostics = {virtual_text = true, underline = true},
    header = {
        "████████╗██╗  ██╗██╗   ██╗ ██████╗██╗  ██╗",
        "╚══██╔══╝██║  ██║╚██╗ ██╔╝██╔════╝██║ ██╔╝",
        "   ██║   ███████║ ╚████╔╝ ██║     █████╔╝",
        "   ██║   ██╔══██║  ╚██╔╝  ██║     ██╔═██╗",
        "   ██║   ██║  ██║   ██║   ╚██████╗██║  ██╗",
        "   ╚═╝   ╚═╝  ╚═╝   ╚═╝    ╚═════╝╚═╝  ╚═╝",
        "      ███╗   ██╗██╗   ██╗██╗███╗   ███╗",
        "      ████╗  ██║██║   ██║██║████╗ ████║",
        "      ██╔██╗ ██║██║   ██║██║██╔████╔██║",
        "      ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
        "      ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
        "      ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
    },
    plugins = {
        init = {
            {
                "sbdchd/neoformat",
                config = function()
                    -- Use deno for formatting
                    vim.g.neoformat_enabled_typescript = {"denofmt"}
                    vim.g.neoformat_enabled_typescriptreact = {"denofmt"}
                    vim.g.neoformat_enabled_javascript = {"denofmt"}
                    vim.g.neoformat_enabled_javascriptreact = {"denofmt"}
                    vim.g.neoformat_enabled_markdown = {"denofmt"}
                    vim.g.neoformat_enabled_json = {"denofmt"}
                end
            },
            {"nkrkv/nvim-treesitter-rescript"},
            {"nvim-treesitter/nvim-treesitter-angular"},
            {
                "LhKipp/nvim-nu",
                config = function ()
                    require('nu').setup{}
                end
            },
            {
                "opdavies/toggle-checkbox.nvim",
                config = function()
                    vim.keymap.set("n", "<leader><leader>t", ":lua require('toggle-checkbox').toggle()<CR>")
                end
            },
            {
                "lewis6991/hover.nvim",
                config = function()
                    require("hover").setup {
                        init = function()
                            -- Require providers
                            require("hover.providers.lsp")
                            -- require('hover.providers.gh')
                            -- require('hover.providers.jira')
                            -- require('hover.providers.man')
                            -- require('hover.providers.dictionary')
                        end,
                        preview_opts = {
                            border = nil
                        },
                        -- Whether the contents of a currently open hover window should be moved
                        -- to a :h preview-window when pressing the hover keymap.
                        preview_window = false,
                        title = true
                    }

                    -- Setup keymaps
                    vim.keymap.set("n", "K", require("hover").hover, {desc = "hover.nvim"})
                    vim.keymap.set("n", "gK", require("hover").hover_select, {desc = "hover.nvim (select)"})
                end
            }
        }
    },
    polish = function()
        -- Set autocommands
        vim.api.nvim_create_augroup("ShowDiagnostics", {})
        vim.api.nvim_create_autocmd("CursorHold,CursorHoldI", {
            desc = "Show line diagnostics automatically in hover window",
            group = "ShowDiagnostics",
            pattern = "*",
            command = "lua vim.diagnostic.open_float(nil, {focus=false})"
        })

        vim.o.updatetime = 250

        -- Make background transparent
        vim.cmd([[
            highlight Normal ctermbg=none
            highlight NonText ctermbg=none
        ]])

        vim.cmd([[
            if &buftype!~?'nofile'
                highlight ExtraWhitespace ctermbg=red guibg=red
                match ExtraWhitespace /\s\+$/
            endif
            autocmd BufWinEnter * if &buftype!~?'nofile' | match ExtraWhitespace /\s\+$/ | endif
            autocmd InsertEnter * if &buftype!~?'nofile' | match ExtraWhitespace /\s\+\%#\@<!$/ | endif
            autocmd InsertLeave * if &buftype!~?'nofile' | match ExtraWhitespace /\s\+$/ | endif
            autocmd BufWinLeave * if &buftype!~?'nofile' | call clearmatches() | endif
        ]])

        -- Quick config edit
        vim.keymap.set("n", "<leader><leader>e", ":e ~/.dotfiles/config/.config/nvim/lua/user/init.lua<CR>")
    end
}

return config
