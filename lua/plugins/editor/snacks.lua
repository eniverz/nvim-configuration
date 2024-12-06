return {
    {
        "folke/snacks.nvim",
        opts = {
            bigfile = {
                enable = true,
                size = require("config.settings").large_buf.size, -- unit: bytes
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
                        features.matchparen()
                    end
                    if vim.tbl.contains(features, "syntax") then
                        features.syntax(ctx)
                    end
                    if vim.tbl.contains(features, "treesitter") then
                        bigfile.treesitter(ctx)
                    end
                    if vim.tblcontains(features, "vimopts") then
                        features.vimopts()
                    end
                end,
            },
            dashboard = {
                preset = {
                    keys = {
                        { icon = " ", desc = "Scheme Change", key = "t", action = ":Telescope colorscheme" },
                        { icon = "󰋚 ", desc = "File history", key = "e", action = ":Telescope oldfiles" },
                        { icon = " ", desc = "Project find", key = "p", action = ":Telescope projects" },
                        { icon = "󰈞 ", desc = "File find", key = "f", action = ":Telescope find_files" },
                        { icon = " ", desc = "Word find", key = "w", action = ":Telescope live_grep" },
                        { icon = " ", desc = "Restore Session", key = "s", action = ":Telescope resession" },
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
                    { icon = " ", title = "Recent Files", section = "recent_files", limit = 5, cwd = true, indent = 2, padding = 1 },
                    { icon = " ", title = "Projects", section = "projects", limit = 5, indent = 2, padding = 1 },
                    { section = "startup" },
                    { text = { " Have Fun with neovim", hl = "SnacksDashboardDesc" }, align = "center" },
                },
            },
        },
    },
    {
        "catppuccin/nvim",
        optional = true,
        opts = { integrations = { snacks = true } },
    },
}
