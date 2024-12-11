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
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = { ensure_installed = { "pyright", "black", "isort", "debugpy" } },
    },
    {
        "neovim/nvim-lspconfig",
        optional = true,
        opts = function(_, opts)
            opts.server = opts.server or {}
            opts.server.pyright = {
                filetypes = { "python" },
                before_init = function(_, config)
                    local path = vim.fn.exepath("python")
                    local sep = require("config.global").is_windows and "\\" or "/"
                    local conda_prefix = vim.env.CONDA_PREFIX
                    local venv_prefix = vim.env.VIRTUAL_ENV
                    if conda_prefix ~= nil and conda_prefix ~= "" then
                        path = conda_prefix .. sep .. "bin" .. sep .. "python"
                    elseif venv_prefix ~= nil and venv_prefix ~= "" then
                        path = venv_prefix .. sep .. "bin" .. sep .. "python"
                    end

                    config.settings.python.pythonPath = path
                end,
            }
        end,
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                python = { "isort", "black" },
            },
            formatters = {
                black = {
                    meta = {
                        url = "https://github.com/psf/black",
                        description = "The uncompromising Python code formatter.",
                    },
                    command = "black",
                    args = function(_, _)
                        local line_length = 160
                        return {
                            "--stdin-filename",
                            "$FILENAME",
                            "--line-length",
                            line_length,
                            "--quiet",
                            "-",
                        }
                    end,
                },
            },
        },
    },
}
