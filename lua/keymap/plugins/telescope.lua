local bind = require("keymap.bind")
local map_callback = bind.map_callback

bind.nvim_load_mapping({
    ["n|<leader>gB"] = map_callback(function()
            require("telescope.builtin").git_branches({ use_file_path = true })
        end)
        :with_silent()
        :with_noremap()
        :with_desc("find: git branches"),
    ["n|<leader>fu"] = map_callback(function()
            require("telescope").extensions.undo.undo()
        end)
        :with_noremap()
        :with_silent()
        :with_desc("edit: Show undo history"),
})
