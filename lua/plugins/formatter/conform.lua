-- formatter
return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = { stop_after_first = false },
    keys = {
        {"<leader>lf", function() require("conform").format({lsp_fallback = true, async = false, timeout_ms = 500}) end, mode = {"n", "v"}, desc = "Conform: format"},
        {"<leader>ln", "<Cmd>ConformInfo<CR>", desc = "Conform: show format info"},
    },
    config = function(_, opts)
        require("conform").setup(opts)
    end,
}
