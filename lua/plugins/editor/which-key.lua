-- show keymap in the bottom of the screen
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
                { "<leader>b", group = icons.ui.Buffer .. " Buffer" },
                { "<leader>C", group = icons.misc.Gavel .. " Crates" },
                { "<leader>d", group = icons.ui.Bug .. " Debug" },
                { "<leader>f", group = icons.ui.Telescope .. " Fuzzy Find" },
                { "<leader>g", group = icons.git.Git .. " Git" },
                { "<leader>l", group = icons.misc.LspAvailable .. " Lsp" },
                { "<leader>n", group = icons.ui.FolderOpen .. " Nvim Tree" },
                { "<leader>p", group = icons.ui.Package .. " Package" },
                { "<leader>s", group = icons.cmp.tmux .. "Session" },
                { "<leader>t", group = icons.ui.Terminal .. " Terminal" },
                { "<leader>T", group = icons.ui.Tasks .. " Tasks" },
                { "<leader>w", group = icons.misc.ManUp .. " Window" },
                { "<leader>u", group = icons.ui.Window .. " UI" },
                { "<leader>z", group = icons.ui.BookMark .. " Fold" },
                { "<leader>x", group = icons.ui.Trouble .. " Trouble" },
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

                -- window = {
                --     border = "none",
                --     position = "bottom",
                --     margin = { 1, 0, 1, 0 },
                --     padding = { 1, 1, 1, 1 },
                --     winblend = 0,
                -- },
                disable = { filetypes = { "TelescopePrompt" } },
            })
        end,
    },
    {
        "catppuccin",
        optional = true,
        ---@type CatppuccinOptions
        opts = { integrations = { which_key = true } },
    },
}
