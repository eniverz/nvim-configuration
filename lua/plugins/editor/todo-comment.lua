-- highlight TODO, etc. and jump to them
return {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
    event = { "BufRead", "BufNewFile" },
    dependencies = {
        { "nvim-lua/plenary.nvim", lazy = true },
    },
    opts = {},
}
