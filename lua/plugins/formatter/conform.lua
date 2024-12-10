-- formatter
return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
    config = function(_, opts)
        require("conform").setup(opts)
    end,
}
