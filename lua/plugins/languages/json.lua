return {
    {
        -- formatter
        "b0o/schemastore.nvim",
        lazy = true,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed =
                    require("utils.core").list_insert_unique(opts.ensure_installed, { "json", "jsonc" })
            end
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = function(_, opts)
            opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "json-lsp" })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        optional = true,
        opts = function(_, opts)
            opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "jsonls" })
        end,
    },
}
