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
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "pyright", "black", "isort", "debugpy" })
            end
        end,
    },
    {
        "linux-cultist/venv-selector.nvim",
        cmd = "VenvSelect",
        branch = "regexp",
        enabled = vim.fn.executable("fd") == 1 or vim.fn.executable("fdfind") == 1 or vim.fn.executable("fd-find") == 1,
        opts = {},
        ft = "python",
        keys = {
            { "<leader>vs", "<Cmd>VenvSelect<CR>", desc = "Select Python Virtual Environment" },
            {
                "<leader>vd",
                function()
                    require("venv-selector").deactivate()
                end,
                desc = "Deactivate Python Virtual Environment",
            },
        },
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                python = { "isort", "black" },
            },
            formatters = {
                black = { args = { "--stdin-filename", "$FILENAME", "--line-length", 160, "--quiet", "-" } },
                isort = { prepend_args = { "-l", 160 } },
            },
        },
    },
}
