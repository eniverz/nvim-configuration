return {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
    event = "User File",
    dependencies = {
        { "nvim-lua/plenary.nvim", lazy = true },
    },
    opts = {},
}
