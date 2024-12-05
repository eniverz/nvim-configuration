local bind = require("keymap.bind")
local map_cu = bind.map_cu

bind.nvim_load_mapping({
    ["n|<A-s>"] = map_cu("SudaWrite"):with_silent():with_noremap():with_desc("editn: Save file using sudo"),
})
