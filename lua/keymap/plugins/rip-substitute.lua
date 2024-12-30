local bind = require("keymap.bind")
local map_callback = bind.map_callback

bind.nvim_load_mapping({
    ["nx|<leader>fr"] = map_callback(function()
            require("rip-substitute").sub()
        end)
        :with_noremap()
        :with_nowait()
        :with_silent()
        :with_desc("RipSubstitute"),
})
