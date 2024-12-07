local bind = require("keymap.bind")
local map_cr = bind.map_cr

bind.nvim_load_mapping({
    ["n|<leader>ls"] = map_cr("AerialToggle!right"):with_noremap():with_nowait():with_silent():with_desc("aerial: symbol outline"),
})
