return {
    {
        "romgrk/barbar.nvim",
        dependencies = {
            "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
            "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
        },
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        opts = function()
            local icons = { diagnostics = require("config.icons").get("diagnostics"), git = require("config.icons").get("git") }
            return {
                icons = {
                    buffer_index = true,
                    diagnostics = {
                        [vim.diagnostic.severity.ERROR] = { enabled = true, icon = icons.diagnostics.Error_alt },
                        [vim.diagnostic.severity.WARN] = { enabled = true, icon = icons.diagnostics.Warning_alt },
                        [vim.diagnostic.severity.INFO] = { enabled = true, icon = icons.diagnostics.Information_alt },
                        [vim.diagnostic.severity.HINT] = { enabled = true, icon = icons.diagnostics.Hint_alt },
                    },
                    gitsigns = {
                        added = { enabled = true, icon = icons.git.Add },
                        changed = { enabled = true, icon = icons.git.Modified },
                        deleted = { enabled = true, icon = icons.git.Remove },
                    },
                },
            }
        end,
    },
    {
        "stevearc/resession.nvim",
        optional = true,
        opts = {
            extensions = {
                barbar = {},
            },
        },
    },
    {
        "catppuccin/nvim",
        optional = true,
        opts = { integrations = { barbar = true } },
    },
}
