-- markdown preview
return {
    {
        "iamcco/markdown-preview.nvim",
        lazy = true,
        ft = "markdown",
        build = ":call mkdp#util#install()",
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function (_, opts)
            if opts ~= nil then
                opts = require("utils.core").list_insert_unique(opts.ensure_installed, {"markdown", "markdown_inline"})
            end
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
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
}
