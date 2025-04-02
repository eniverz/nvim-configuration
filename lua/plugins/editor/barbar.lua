-- tab bar
return {
    {
        "romgrk/barbar.nvim",
        lazy = true,
        event = { "BufReadPost", "BufAdd", "BufNewFile" },
        dependencies = {
            "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
            "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
        },
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        opts = function()
            local icon_config = require("config.icons")
            local icons = { diagnostics = icon_config.get("diagnostics"), git = icon_config.get("git"), ui = icon_config.get("ui") }
            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error_alt,
                        [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning_alt,
                        [vim.diagnostic.severity.INFO] = icons.diagnostics.Information_alt,
                        [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint_alt,
                    },
                    numhl = {
                        [vim.diagnostic.severity.ERROR] = "DiagnosticsSignError",
                        [vim.diagnostic.severity.WARN] = "DiagnosticsSignWarn",
                        [vim.diagnostic.severity.INFO] = "DiagnosticsSignInfo",
                        [vim.diagnostic.severity.HINT] = "DiagnosticsSignHint",
                    },
                },
            })
            return {
                icons = {
                    buffer_index = true,
                    pinned = { button = icons.ui.Pin, filename = true },
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
}
