return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "bash", "fish" })
            end
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "bash-language-server", "shellcheck", "shfmt" })
            end
        end,
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                sh = { "shfmt" },
                bash = { "shfmt" },
                fish = { "fish_indent" },
            },
            formatters = {
                shfmt = {
                    command = "shfmt",
                    args = {
                        "-i", -- indent with 4 spaces
                        "4",
                        "-sr", -- redirect operator will be followed by a space
                        "-kp", -- Keep column alignment paddings
                        "-ci", -- Switch cases will be indented
                        "-filename",
                        "$FILENAME",
                    },
                },
            },
        },
    },
    {
        "mfussenegger/nvim-lint",
        optional = true,
        opts = {
            linters_by_ft = {
                sh = { "shellcheck" },
            },
        },
    },
}
