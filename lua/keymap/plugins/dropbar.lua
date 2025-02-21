local bind = require("keymap.bind")
local map_callback = bind.map_callback

bind.nvim_load_mapping({
    ["n|<leader>;"] = map_callback(function()
            require("dropbar.api").pick()
        end)
        :with_noremap()
        :with_nowait()
        :with_silent()
        :with_desc("Drop bar: pick symbols on bar"),
})
