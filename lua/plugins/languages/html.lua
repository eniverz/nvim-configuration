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
        "williamboman/mason-lspconfig.nvim",
        optional = true,
        opts = function(_, opts)
            opts.ensure_installed =
            require("utils.core").list_insert_unique(opts.ensure_installed, { "html", "cssls", "cssmodules_ls", "emmet_ls", "tailwindcss" })
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = function(_, opts)
            opts.ensure_installed = require("utils.core").list_insert_unique(
                opts.ensure_installed,
                { "html-lsp", "css-lsp", "emmet-ls", "prettierd" }
            )
        end,
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                html = { { "prettierd", "prettier" } },
                css = { { "prettierd", "prettier" } },
                sass = { { "prettierd", "prettier" } },
                scss = { { "prettierd", "prettier" } },
                less = { { "prettierd", "prettier" } },
            },
        },
    },
}
