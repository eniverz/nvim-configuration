return {
    {
        "b0o/schemastore.nvim",
        lazy = true,
        ft = { "yaml" },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "yaml" })
            end
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = function(_, opts)
            opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "yaml-language-server", "prettier" })
        end,
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = { formatters_by_ft = { yaml = { "prettier" } } },
    },
}
