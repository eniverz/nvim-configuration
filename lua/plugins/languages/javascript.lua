return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed =
                    require("utils.core").list_insert_unique(opts.ensure_installed, { "javascript", "typescript" })
            end
            vim.treesitter.language.register("typescriptreact", "javascriptreact")
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        optional = true,
        opts = function(_, opts)
            opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "ts_ls" })
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = function(_, opts)
            opts.ensure_installed =
                require("utils.core").list_insert_unique(opts.ensure_installed, { "typescript-language-server", "prettier" })
        end,
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                javascript = { { "prettier" } },
                typescript = { { "prettier" } },
                javascriptreact = { { "prettier" } },
                typescriptreact = { { "prettier" } },
            },
        },
    },
}
