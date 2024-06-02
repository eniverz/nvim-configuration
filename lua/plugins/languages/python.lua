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
        "neovim/nvim-lspconfig",
        config = function(_, opts)
            require("lspconfig").pyright.setup({
                filetypes = { "python" },
                capabilities = opts.capabilities,
                on_attach = opts.on_attach,
                before_init = function(_, c)
                    local path
                    local conda_prefix = vim.env.CONDA_PREFIX
                    local venv_prefix = vim.env.VIRTUAL_ENV
                    if conda_prefix ~= nil and conda_prefix ~= "" then
                        path = conda_prefix .. "/bin/python"
                    else if venv_prefix ~= nil and venv_prefix ~= "" then
                            path = venv_prefix .. "/bin/python"
                        else
                            path = vim.fn.exepath "python"
                        end
                    end

                    c.settings.python.pythonPath = path
                end,
            })
            require("lspconfig").pylsp.setup({
                capabilities = opts.capabilities,
                on_attach = opts.on_attach,
                before_init = function(_, c)
                    local path
                    local conda_prefix = vim.env.CONDA_PREFIX
                    local venv_prefix = vim.env.VIRTUAL_ENV
                    if conda_prefix ~= nil and conda_prefix ~= "" then
                        path = conda_prefix .. "/bin/python"
                    else if venv_prefix ~= nil and venv_prefix ~= "" then
                            path = venv_prefix .. "/bin/python"
                        else
                            path = vim.fn.exepath "python"
                        end
                    end
                    c.settings.python.pythonPath = path
                end,
                cmd = { "pylsp" },
                filetypes = { "python" },
                settings = {
                    pylsp = {
                        plugins = {
                            -- Lint
                            ruff = {
                                enabled = true,
                                select = {
                                    -- enable pycodestyle
                                    "E",
                                    -- enable pyflakes
                                    "F",
                                },
                                ignore = {
                                    -- ignore E501 (line too long)
                                    -- "E501",
                                    -- ignore F401 (imported but unused)
                                    -- "F401",
                                },
                                extendSelect = { "I" },
                                severities = {
                                    -- Hint, Information, Warning, Error
                                    F401 = "I",
                                    E501 = "I",
                                },
                            },
                            flake8 = { enabled = false },
                            pyflakes = { enabled = false },
                            pycodestyle = { enabled = false },
                            mccabe = { enabled = false },

                            -- Code refactor
                            rope = { enabled = true },
                        },
                    },
                },
            })
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
        lazy = true,
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
