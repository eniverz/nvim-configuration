return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "css" })
            end
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed =
                    require("utils.core").list_insert_unique(opts.ensure_installed, { "css-lsp", "cssmodules-language-server", "tailwindcss-language-server" })
            end
        end,
    },
    {
        "neovim/nvim-lspconfig",
        optional = true,
        opts = {
            server = {
                cssls = { init_options = { provideFormatter = false } },
                cssmodules_ls = {},
                tailwindcss = {
                    root_dir = function(fname)
                        local root_pattern = require("lspconfig").util.root_pattern(
                            "tailwind.config.mjs",
                            "tailwind.config.cjs",
                            "tailwind.config.js",
                            "tailwind.config.ts",
                            "postcss.config.js",
                            "config/tailwind.config.js",
                            "assets/tailwind.config.js"
                        )
                        return root_pattern(fname)
                    end,
                },
            },
        },
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                css = { "prettier" },
                sass = { "prettier" },
                scss = { "prettier" },
                less = { "prettier" },
            },
        },
    },
}
