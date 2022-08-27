local config = {
    diagnostics = {virtual_text = true, underline = true},
    header = {
        "████████ ██   ██ ██    ██  █████  ██   ██",
        "   ██    ██   ██  ██  ██  ██   ██ ██  ██",
        "   ██    ███████   ████   ██      █████",
        "   ██    ██   ██    ██    ██   ██ ██  ██",
        "   ██    ██   ██    ██     █████  ██   ██",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██"
    },
    plugins = {
        init = {{"sbdchd/neoformat"}, {"nkrkv/nvim-treesitter-rescript"}}
    },
    polish = function()
        -- Set autocommands
        vim.api.nvim_create_augroup("neofmt", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
            desc = "Format file with Neoformat on save",
            group = "neofmt",
            pattern = "*",
            command = "silent Neoformat"
        })
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
        -- Use deno for formatting
        vim.g.neoformat_enabled_typescript = {"denofmt"}
        vim.g.neoformat_enabled_javascript = {"denofmt"}
        vim.g.neoformat_enabled_markdown = {"denofmt"}
        vim.g.neoformat_enabled_json = {"denofmt"}
    end
}

return config
