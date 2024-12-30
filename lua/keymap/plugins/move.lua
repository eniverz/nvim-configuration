local bind = require("keymap.bind")
local map_cr = bind.map_cr

bind.nvim_load_mapping({
    ["ni|<C-S-Up>"] = map_cr("MoveLine -1"):with_noremap():with_silent():with_desc("Move line up"),
    ["ni|<C-S-Down>"] = map_cr("MoveLine 1"):with_noremap():with_silent():with_desc("Move line down"),
    ["v|<C-S-Up>"] = map_cr("MoveBlock -1"):with_noremap():with_silent():with_desc("Move block up"),
    ["v|<C-S-Down>"] = map_cr("MoveBlock 1"):with_noremap():with_silent():with_desc("Move block down"),
})
