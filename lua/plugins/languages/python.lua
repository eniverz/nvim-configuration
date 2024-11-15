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
        opts = function(_, opts)
            opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "pyright", "black", "isort", "debugpy" })
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
                    args = function(self, ctx)
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
                    cwd = require("conform.util").root_file({
                        -- https://black.readthedocs.io/en/stable/usage_and_configuration/the_basics.html#configuration-via-a-file
                        "pyproject.toml",
                    }),
                },
            },
        },
    },
}
