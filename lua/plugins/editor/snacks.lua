return {
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
    },
}
