-- markdown preview
return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            if opts ~= nil then
                opts = require("utils.core").list_insert_unique(opts.ensure_installed, { "markdown", "markdown_inline" })
            end
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = function(_, opts)
            opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "marksman" })
        end,
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                markdown = { { "prettierd", "prettier" } },
                ["markdown.mdx"] = { { "prettierd", "prettier" } },
            },
        },
    },
    {
        "catppuccin",
        optional = true,
        opts = {
            integrations = { markdown = true },
        },
    },
}
