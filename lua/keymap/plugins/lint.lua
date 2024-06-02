local bind = require("keymap.bind")
local map_callback = bind.map_callback

bind.nvim_load_mapping({
    ["n|<leader>li"] = map_callback(function ()
            require("lint").try_lint()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("lint: try lint"),
})
