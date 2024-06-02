local bind = require("keymap.bind")
local map_cmd = bind.map_cmd

bind.nvim_load_mapping({
    ["n|fT"] = map_cmd("<Cmd>TodoTelescope<CR>"):with_silent():with_noremap():with_desc("find: todos"),
})
