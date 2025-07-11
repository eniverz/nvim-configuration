return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "lua", "luap" })
            end
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "lua-language-server", "stylua", "selene" })
            end
        end,
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = { library = { "snacks.nvim", "lazy.nvim" } },
    },
    {
        "saghen/blink.cmp",
        optional = true,
        opts = {
            sources = {
                default = { "lazydev" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        fallbacks = { "lsp" },
                    },
                },
            },
        },
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
            },
            formatters = {
                stylua = {
                    command = "stylua",
                    args = {
                        "--search-parent-directories",
                        "--stdin-filepath",
                        "$FILENAME",
                        "-",
                    },
                    prepend_args = function()
                        local line_end = "Unix"
                        local os_name = (vim.uv or vim.loop).os_uname().sysname
                        if os_name:find("Windows") then
                            line_end = "Windows"
                        end

                        return {
                            "--no-editorconfig",
                            "--column-width",
                            "160",
                            "--indent-width",
                            vim.opt_local.shiftwidth._value,
                            "--line-endings",
                            line_end,
                            "--config-path",
                            vim.fn.stdpath("config") .. "/lua/config/format/stylua.config.toml",
                        }
                    end,
                    range_args = function(_, ctx)
                        local start_offset, end_offset = require("conform.util").get_offsets_from_range(ctx.buf, ctx.range)

                        return {
                            "--search-parent-directories",
                            "--stdin-filepath",
                            "$FILENAME",
                            "--range-start",
                            tostring(start_offset),
                            "--range-end",
                            tostring(end_offset),
                            "-",
                        }
                    end,
                },
            },
        },
    },
    {
        "mfussenegger/nvim-lint",
        optional = true,
        opts = { linters_by_ft = { lua = { "selene" } } },
    },
}
