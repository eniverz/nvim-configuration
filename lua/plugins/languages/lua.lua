return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed =
                    require("utils.core").list_insert_unique(opts.ensure_installed, { "lua", "luap" })
            end
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        optional = true,
        opts = function(_, opts)
            opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "lua_ls" })
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = function(_, opts)
            opts.ensure_installed = require("utils.core").list_insert_unique(
                opts.ensure_installed,
                { "lua-language-server", "stylua", "selene" }
            )
        end,
    },
    {
        "folke/neodev.nvim",
        lazy = true,
        config = true,
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
                            "--line-endings",
                            line_end,
                            "--column-width",
                            "120",
                            "--indent-type",
                            "Spaces",
                            "--indent-width",
                            "4",
                            "--quote-style",
                            "AutoPreferDouble",
                            "--call-parentheses", -- Whether parentheses should be applied on function calls with a single string/table argument.
                            "Always",
                        }
                    end,
                    range_args = function(_, ctx)
                        local start_offset, end_offset =
                            require("conform.util").get_offsets_from_range(ctx.buf, ctx.range)

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
                    -- cwd = require("conform.util").root_file({
                    -- ".stylua.toml",
                    -- "stylua.toml",
                    -- }),
                },
            },
        },
    },
    {
        "mfussenegger/nvim-lint",
        optional = true,
        opts = {
            linters_by_ft = {
                lua = { "selene" },
            },
        },
    },
}
