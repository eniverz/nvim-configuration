-- markdown preview
return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
            if opts ~= nil then
                opts = require("utils.core").list_insert_unique(opts.ensure_installed, { "markdown", "markdown_inline" })
            end
        end,
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            log_level = "debug",
            render_modes = true,
            overrides = {
                buftype = {
                    nofile = {
                        render_modes = { "n", "c", "i" },
                        debounce = 5,
                        code = {
                            left_pad = 0,
                            right_pad = 0,
                            language_pad = 0,
                        },
                    },
                },
                filetype = {},
            },
        },
        ft = { "markdown" },
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
