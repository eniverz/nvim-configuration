local bind = require("keymap.bind")
local map_callback = bind.map_callback

bind.nvim_load_mapping({
    ["n|<leader>ur"] = map_callback(function()
            require("illuminate").toggle_buf()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("illuminate: toggle reference highlight in buf"),
    ["n|<leader>uR"] = map_callback(function()
            require("illuminate").toggle()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("illuminate: toggle reference highlight (global)"),
})
