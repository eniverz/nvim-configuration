return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "bash" })
            end
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed =
                    require("utils.core").list_insert_unique(opts.ensure_installed, { "bash-language-server", "shellcheck", "shfmt" })
            end
        end,
    },
    {
        "neovim/nvim-lspconfig",
        optional = true,
        opts = {
            server = { bashls = { settings = { bashIde = { globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command|.zsh)" } } } },
        },
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                sh = { "shfmt" },
                bash = { "shfmt" },
                fish = { "shfmt" },
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
