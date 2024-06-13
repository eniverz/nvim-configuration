return {
    "Shatur/neovim-tasks",
    lazy = true,
    cmd = { "Tasks" },
    ft = { "c", "cpp", "cmake", "make" },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function(_, opts)
        require("tasks").setup(opts)
    end,
}
