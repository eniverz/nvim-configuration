local bind = require("keymap.bind")
local map_callback = bind.map_callback

bind.nvim_load_mapping({
    ["n|<leader>ud"] = map_callback(function()
            require("notify").dismiss({ pending = true, silent = true })
        end)
        :with_silent()
        :with_noremap()
        :with_desc("notify: dismiss notifications"),
})
