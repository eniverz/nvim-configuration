return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "python", "toml" })
            end
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        optional = true,
        opts = function(_, opts)
            opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "pyright" })
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        optional = true,
        opts = function(_, opts)
            opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "python" })
            if not opts.handlers then opts.handlers = {} end
            opts.handlers.python = function() end -- make sure python doesn't get set up by mason-nvim-dap, it's being set up by nvim-dap-python
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = function(_, opts)
            opts.ensure_installed =
            require("utils.core").list_insert_unique(opts.ensure_installed, { "pyright", "black", "isort", "debugpy" })
        end,
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                python = { "isort", "black" },
            },
            formatter = {
                isort = {
                    command = "isort",
                    args = function(self, ctx)
                        local line_end = "\n"
                        local os_name = (vim.uv or vim.loop).os_uname().sysname
                        if os_name:find "Darwin" then line_end = "\r" end

                        local line_length = 120

                        return {
                            "--stdout",
                            "--line-ending",
                            line_end,
                            "--line-length",
                            line_length,
                            "--filename",
                            "$FILENAME",
                            "-",
                        }
                    end
                }
            }
        },
    },
    {
        "kmontocam/nvim-conda",
        lazy = true,
        ft = "python",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
}
