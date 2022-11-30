-- vim:set ts=4 sw=4 sts=4 et :

require 'nvim-treesitter.install'.compilers = { "gcc" }

local function FileType()
    local bt = vim.bo.buftype
    local ft = vim.bo.filetype

    return bt ~= 'nofile' and ft ~= '' and ft ~= 'neo-tree'
end

local function CallIfFileType(cmd)
    return function()
        if FileType() then
            vim.cmd(cmd)
        end
    end
end

local function CreateTrailingCmd(auto, group, cmd)
    vim.api.nvim_create_autocmd(auto, {
        desc = "Match extra whitespace",
        group = "MatchTrailing",
        pattern = "*",
        command = "lua " .. cmd .. "()"
    })
end

BufWinEnterTrail = CallIfFileType([[ match ExtraWhitespace /\s\+$/ ]])
InsertEnterTrail = CallIfFileType([[ match ExtraWhitespace /\s\+\%#\@<!$/ ]])
InsertLeaveTrail = CallIfFileType([[ match ExtraWhitespace /\s\+$/ ]])
BufWinLeaveTrail = CallIfFileType([[ call clearmatches() ]])

local function MatchTrailingWhitespace()
    vim.cmd([[
        highlight ExtraWhitespace ctermbg=red guibg=red
    ]])

    vim.api.nvim_create_augroup("MatchTrailing", {})
    CreateTrailingCmd("BufWinEnter", "MatchTrailing", "BufWinEnterTrail")
    CreateTrailingCmd("InsertEnter", "MatchTrailing", "InsertEnterTrail")
    CreateTrailingCmd("InsertLeave", "MatchTrailing", "InsertLeaveTrail")
    CreateTrailingCmd("BufWinLeave", "MatchTrailing", "BufWinLeaveTrail")
end

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
            {
                "hkupty/nvimux", config = function()
                -- Nvimux configuration
                local nvimux = require('nvimux')
                nvimux.setup{
                    config = {
                        prefix = '<C-a>',
                    },
                    bindings = {
                        {{'n', 'v', 'i', 't'}, 's', nvimux.commands.horizontal_split},
                        {{'n', 'v', 'i', 't'}, 'v', nvimux.commands.vertical_split},
                    }
                }
                end
            },
            {"nvim-treesitter/nvim-treesitter-angular"},
            {
                "LhKipp/nvim-nu",
                config = function()
                    vim.api.nvim_create_autocmd("BufWinEnter", {
                        desc = "Do nvim-nu setup",
                        pattern = "*.nu",
                        command = "lua require('nu').setup{}"
                    })
                end
            },
            {"dstein64/vim-startuptime"},
            {
                "opdavies/toggle-checkbox.nvim",
                config = function()
                    vim.keymap.set("n", "<leader><leader>", ":lua require('toggle-checkbox').toggle()<CR>")
                end
            },
            {
                "lewis6991/hover.nvim",
                config = function()
                    require("hover").setup {
                        init = function() require("hover.providers.lsp") end,
                        preview_opts = { border = nil },
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

        require("notify").setup({
          background_colour = "#000000",
        })

        vim.o.updatetime = 250

        -- Make background transparent
        vim.cmd([[
            highlight Normal ctermbg=none
            highlight NonText ctermbg=none
            highlight Normal guibg=none
            highlight NonText guibg=none
        ]])

        MatchTrailingWhitespace()

        -- Quick config edit
        vim.keymap.set("n", "<leader>E", ":e ~/.dotfiles/config/.config/nvim/lua/user/init.lua<CR>")
        -- Print date
        vim.keymap.set("n", "<leader>D", ":pu=execute('lua print(os.date())')<CR>kJ")
        -- Neoformat
        vim.keymap.set("n", "<leader>F", ":Neoformat<CR><CR>")

        -- JQ formatting
        vim.keymap.set("v", "<leader>jj", ":% !jq .<CR>")
        vim.keymap.set("v", "<leader>jc", ":% !jq -c .<CR><CR>")
    end
}

return config
