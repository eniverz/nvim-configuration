local bind = require("keymap.bind")
local map_callback = bind.map_callback

bind.nvim_load_mapping({
    ["n|<leader>ft"] = map_callback(function()
            Snacks.picker.todo_comments()
        end)
        :with_noremap()
        :with_silent()
        :with_nowait()
        :with_desc("Snacks: pick todo comments"),
})
