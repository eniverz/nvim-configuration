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
        "mfussenegger/nvim-dap",
        optional = true,
        config = function ()
            local dap = require("dap")
            local utils = require("utils.dap")

            local function is_empty(s)
                return s == nil or s == ""
            end

            dap.configurations.python = {
                {
                    -- The first three options are required by nvim-dap
                    type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
                    request = "launch",
                    name = "Debug",
                    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
                    console = "integratedTerminal",
                    program = utils.input_file_path(),
                    pythonPath = function()
                        if not is_empty(vim.env.CONDA_PREFIX) then
                            return vim.env.CONDA_PREFIX .. "/bin/python"
                        else
                            return "python3"
                        end
                    end,
                },
            }

        end
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
