-- integrated utils
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = {
            enabled = true,
            size = require("config.settings").settings.large_buf.size, -- unit: bytes
            ---@param ctx {buf: number, ft:string}
            setup = function(ctx)
                Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
                local features = require("config.settings").large_buf.features
                local bigfile = require("utils.bigfile")

                if vim.tbl.contains(features, "cmp") then
                    bigfile.cmp()
                end
                if vim.tbl.contains(features, "indent_blankline") then
                    bigfile.indent_blankline()
                end
                if vim.tbl.contains(features, "illuminate") then
                    bigfile.illuminate(ctx)
                end
                if vim.tbl.contains(features, "lsp") then
                    bigfile.lsp(ctx)
                end
                if vim.tbl.contains(features, "matchparen") then
                    bigfile.matchparen()
                end
                if vim.tbl.contains(features, "syntax") then
                    bigfile.syntax(ctx)
                end
                if vim.tbl.contains(features, "treesitter") then
                    bigfile.treesitter(ctx)
                end
                if vim.tblcontains(features, "vimopts") then
                    bigfile.vimopts()
                end
            end,
        },
        dashboard = {
            enabled = true,
            preset = {
                keys = {
                    {
                        icon = " ",
                        desc = "Scheme Change",
                        key = "t",
                        action = function()
                            Snacks.picker.colorschemes()
                        end,
                    },
                    {
                        icon = "󰋚 ",
                        desc = "File history",
                        key = "e",
                        action = function()
                            Snacks.picker.recent()
                        end,
                    },
                    {
                        icon = "󰈞 ",
                        desc = "File find",
                        key = "f",
                        action = function()
                            Snacks.picker.files()
                        end,
                    },
                    {
                        icon = " ",
                        desc = "Word find",
                        key = "w",
                        action = function()
                            Snacks.picker.grep()
                        end,
                    },
                    {
                        icon = " ",
                        desc = "Restore Session",
                        key = "s",
                        action = function()
                            require("persistence").select()
                        end,
                    },
                    {
                        icon = { "󰒲 ", hl = "Title" },
                        desc = { "Lazy", hl = "String" },
                        key = "l",
                        action = ":Lazy",
                        enabled = package.loaded.lazy ~= nil,
                    },
                    { icon = { " ", hl = "Title" }, desc = { "Quit", hl = "String" }, key = "q", action = ":qa" },
                },
            },
            formats = {
                key = function(item)
                    return { { "[", hl = "special" }, { item.key, hl = "Number" }, { "]", hl = "special" }, align = "center" }
                end,
                icon = function(item)
                    return { { item.icon, hl = "Title" }, align = "center" }
                end,
                desc = function(item)
                    return { { item.desc, hl = "String" }, align = "center" }
                end,
            },
            sections = {
                { section = "header", align = "center" },
                { section = "keys", gap = 1, padding = 1 },
                { icon = " ", title = "Projects", section = "projects", limit = 5, indent = 2, padding = 1 },
                { icon = " ", title = "Recent Files", section = "recent_files", limit = 5, indent = 2, padding = 1 },
                { section = "startup" },
                { text = { " Have Fun with neovim", hl = "SnacksDashboardDesc" }, align = "center" },
            },
        },
        image = { enabled = true, math = { enabled = false } },
        indent = {
            indent = {
                char = "│",
                hl = {
                    "IndentRainbowRed",
                    "IndentRainbowOrange",
                    "IndentRainbowYellow",
                    "IndentRainbowGreen",
                    "IndentRainbowBlue",
                    "IndentRainbowViolet",
                    "IndentRainbowCyan",
                },
            },
            scope = {
                char = "│",
                hl = { "RainbowDelimiterCyan" },
            },
        },
        notifier = {
            enabled = true,
            icons = {
                debug = require("config.icons").get("dap").Debugger,
                error = require("config.icons").get("diagnostics").Error,
                info = require("config.icons").get("diagnostics").Information,
                trace = require("config.icons").get("diagnostics").Hint,
                warn = require("config.icons").get("diagnostics").Warning,
            },
            style = "compact",
        },
        ---@type snacks.picker.Config
        picker = {
            sources = {
                grep = { hidden = true },
                files = { hidden = true },
                select = {
                    layout = {
                        reverse = false,
                        layout = {
                            width = 0.5,
                            min_width = 80,
                            height = 0.4,
                            min_height = 3,
                            box = "vertical",
                            border = "rounded",
                            title = "{title}",
                            title_pos = "center",
                            { win = "input", height = 1, border = "bottom" },
                            { win = "list", border = "none" },
                            { win = "preview", title = "{preview}", height = 0.4, border = "top" },
                        },
                    },
                },
            },
            layout = {
                reverse = true,
                layout = {
                    box = "horizontal",
                    backdrop = false,
                    width = 0.8,
                    height = 0.9,
                    border = "none",
                    {
                        box = "vertical",
                        { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
                        { win = "input", height = 1, border = "rounded", title = "{source} {live}", title_pos = "center" },
                    },
                    {
                        win = "preview",
                        width = 0.5,
                        border = "rounded",
                        title = " Preview ",
                        title_pos = "center",
                    },
                },
            },
        },
        quickfile = { enabled = true },
        statuscolumn = {
            enabled = true,
            left = { "sign", "fold" }, -- priority of signs on the left (high to low)
            right = { "git", "mark" }, -- priority of signs on the right (high to low)
            folds = { open = true, git_hl = true },
        },
        scroll = { enabled = true },
        ---@type snacks.terminal.Config
        terminal = {
            win = {
                relative = "editor",
                border = "rounded",
                position = "float",
                height = 0.8,
                width = 0.85,
                keys = { hide = { "<A-d>", "hide", mode = "t" } },
            },
        },
        words = { enabled = true },
    },
    keys = {
        {"<leader>ud", function() Snacks.notifier.hide() end, desc = "Snacks: clear all notifications"},
        {"<leader>un", function() Snacks.notifier.show_history() end, desc = "Snacks: show notifications history"},

        {"<leader>gg", function() Snacks.lazygit.open() end, desc = "Snacks: open lazygit panel"},
        {"<leader>gl", function() Snacks.lazygit.log() end, desc = "Snacks: open lazygit log panel"},
        {"<leader>gb", function() Snacks.lazygit.blame_line() end, desc = "Snacks: showgit commit in current line"},

        {"]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Snacks: jump to next word"},
        {"[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Snacks: jump to prev word"},

        {"<leader>tf", function() Snacks.terminal.toggle() end, desc = "Snacks: toggle float terminal"},
        {"<leader>th", function() Snacks.terminal.toggle(nil, { win = { position = "bottom", height = 0.4 }, env = { NVIM_TERM = "horizontal" } }) end, desc = "Snacks: toggle horizontal terminal"},
        {"<leader>tv", function() Snacks.terminal.toggle(nil, { win = { position = "right", width = 0.4 }, env = {NVIM_TERM = "vertical" }  }) end, desc = "Snacks: toggle vertical terminal"},

        {"<leader>f<space>", function() Snacks.picker() end, desc = "Snacks: pickers"},
        {"<leader>ff", function() Snacks.picker.files() end, desc = "Snacks: pick files"},
        {"<leader>fw", function() Snacks.picker.grep() end, desc = "Snacks: pick word in project"},
        {"<leader>f<CR>", function() Snacks.picker.resume() end, desc = "Snacks: resume last picker"},
        {"<leader>fh", function() Snacks.picker.lsp_references() end, desc = "Snacks: pick lsp references"},
        {"<leader>gt", function() Snacks.picker.git_status() end, desc = "Snacks: git status"},
        {"<leader>gc", function() Snacks.picker.git_log_file() end, desc = "Snacks: git commit in current file"},
    },
    config = function (_, opts)
        require("snacks").setup(opts)
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("relativenumber", {name = "Relative Number"}):map("<leader>uL")
        Snacks.toggle.option("spell", {name = "Relative Number"}):map("<leader>us")
        Snacks.toggle.treesitter():map("<leader>ut")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.indent():map("<leader>u|")
        Snacks.toggle.zen():map("<leader>uz")
    end
}
