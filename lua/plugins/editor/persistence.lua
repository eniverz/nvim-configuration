-- session manager
return {
    "TropinoneH/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    dependencies = {
        "nvim-telescope/telescope-ui-select.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        opts = { extensions = { ["ui-select"] = { require("telescope.themes").get_dropdown({}) } } },
    },
    opts = {
        dir = require("config.settings").sessions.save_dir, -- directory where session files are saved
        -- minimum number of file buffers that need to be open to save
        -- Set to 0 to always save
        need = 2,
        branch = true, -- use git branch to save session
    },
    config = function(_, opts)
        require("persistence").setup(opts)
        require("telescope").load_extension("ui-select")
    end,
}
