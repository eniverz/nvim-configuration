local bind = require("keymap.bind")
local map_cr = bind.map_cr

bind.nvim_load_mapping({
    ["n|<leader>pm"] = map_cr("Mason"):with_silent():with_noremap():with_desc("Mason: Open Installer"),
})
