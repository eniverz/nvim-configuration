-- formatter
return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = { stop_after_first = false },
    config = function(_, opts)
        require("conform").setup(opts)
    end,
}
