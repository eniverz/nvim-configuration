return function(_, opts)
    local telescope = require "telescope"
    telescope.setup(opts)
    telescope.load_extension("notify")
    telescope.load_extension("frecency")
    telescope.load_extension("fzf")
    telescope.load_extension("live_grep_args")
    telescope.load_extension("notify")
    telescope.load_extension("projects")
    telescope.load_extension("undo")
    telescope.load_extension("zoxide")
    telescope.load_extension("persisted")
    telescope.load_extension("aerial")
end
