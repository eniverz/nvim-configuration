local bind = require("keymap.bind")
local map_callback = bind.map_callback

bind.nvim_load_mapping({
    ["n|<leader>pm"] = map_callback(function()
            require("mason.ui").open()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("mason: open Installer"),
})
