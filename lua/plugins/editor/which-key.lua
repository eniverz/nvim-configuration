-- cheatsheet for keybindings
return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            local icons = {
                ui = require("config.icons").get("ui"),
                misc = require("config.icons").get("misc"),
                git = require("config.icons").get("git", true),
                cmp = require("config.icons").get("cmp", true),
            }
            require("which-key").add({
                { "<leader>b", group = "Buffer", icon = icons.ui.Buffer },
                { "<leader>bs", group = "Buffer Sort", icon = icons.ui.Sort },
                { "<leader>C", group = "Crates", icon = icons.misc.Gavel },
                { "<leader>d", group = "Debug", icon = icons.ui.Bug },
                { "<leader>f", group = "Fuzzy Find", icon = icons.ui.Telescope },
                { "<leader>g", group = "Git", icon = icons.git.Git },
                { "<leader>l", group = "Lsp", icon = icons.misc.LspAvailable },
                { "<leader>p", group = "Package", icon = icons.ui.Package },
                { "<leader>s", group = "Session", icon = icons.cmp.tmux },
                { "<leader>t", group = "Terminal", icon = icons.ui.Terminal },
                { "<leader>w", group = "Window", icon = icons.misc.ManUp },
                { "<leader>u", group = "UI", icon = icons.ui.Window },
                { "<leader>x", group = "Trouble", icon = icons.ui.Trouble },
                { "<leader>o", group = "Overseer", icon = icons.ui.Tasks },
            })
            require("which-key").setup({
                preset = "modern",
                plugins = {
                    presets = {
                        motions = false,
                    },
                },

                icons = {
                    breadcrumb = icons.ui.Separator,
                    separator = icons.misc.Vbar,
                    group = ""
                },

                disable = { ft = { "TelescopePrompt" } },
            })
        end,
    },
}
