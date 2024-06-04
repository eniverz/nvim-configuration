-- show keymap in the bottom of the screen
return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local icons = {
            ui = require("config.icons").get("ui"),
            misc = require("config.icons").get("misc"),
            git = require("config.icons").get("git", true),
            cmp = require("config.icons").get("cmp", true),
        }
        require("which-key").register({
            ["<leader>"] = {
                b = {
                    name = icons.ui.Buffer .. " Buffer",
                },
                C = {
                    name = icons.misc.Gavel .. "Crates",
                },
                d = {
                    name = icons.ui.Bug .. " Debug",
                },
                f = {
                    name = icons.ui.Telescope .. " Fuzzy Find",
                },
                g = {
                    name = icons.git.Git .. "Git",
                },
                l = {
                    name = icons.misc.LspAvailable .. " Lsp",
                },
                n = {
                    name = icons.ui.FolderOpen .. " Nvim Tree",
                },
                p = {
                    name = icons.ui.Package .. " Package",
                },
                s = {
                    name = icons.cmp.tmux .. "Session",
                },
                t = {
                    name = icons.ui.Terminal .. " Terminal",
                },
                w = {
                    name = icons.misc.ManUp .. " Window",
                },
                u = {
                    name = icons.ui.Window .. " UI",
                },
                z = {
                    name = icons.ui.BookMark .. " fold",
                },
                x = {
                    name = icons.ui.Trouble .. " Trouble",
                },
            },
        })
        require("which-key").setup({
            plugins = {
                presets = {
                    operators = false,
                    motions = false,
                    text_objects = false,
                    windows = false,
                    nav = false,
                    z = true,
                    g = true,
                },
            },

            icons = {
                breadcrumb = icons.ui.Separator,
                separator = icons.misc.Vbar,
                group = "",
            },

            window = {
                border = "none",
                position = "bottom",
                margin = { 1, 0, 1, 0 },
                padding = { 1, 1, 1, 1 },
                winblend = 0,
            },
            disable = { filetypes = { "TelescopePrompt" } },
        })
    end,
}
