return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "html", "css" })
            end
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = { ensure_installed = { "html-lsp", "css-lsp", "cssmodules-language-server", "tailwindcss-language-server" } },
    },
    {
        "neovim/nvim-lspconfig",
        optional = true,
        opts = {
            server = {
                html = { init_options = { provideFormatter = false }, filetype = { "html" } },
                cssls = { init_options = { provideFormatter = false } },
                cssmodules_ls = {},
                tailwindcss = {},
            },
        },
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                html = { { "prettier" } },
                css = { { "prettier" } },
                sass = { { "prettier" } },
                scss = { { "prettier" } },
                less = { { "prettier" } },
            },
        },
    },
}
