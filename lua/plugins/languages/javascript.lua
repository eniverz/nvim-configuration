return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "javascript", "typescript", "tsx" })
            end
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "typescript-language-server", "prettier" })
            end
        end,
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
            },
            formatters = {
                prettier = {
                    append_args = {
                        "--config-precedence",
                        "prefer-file",
                        "--print-width",
                        "120",
                        "--tab-width",
                        "4",
                        "--trailing-comma",
                        "none",
                        "--arrow-parens",
                        "avoid",
                        "--no-semi",
                    },
                },
            },
        },
    },
}
