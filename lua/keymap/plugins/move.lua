local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cmd = bind.map_cmd

bind.nvim_load_mapping({
    ["n|<C-S-Up>"] = map_cr("MoveLine -1"):with_noremap():with_silent():with_desc("Move line up"),
    ["n|<C-S-Down>"] = map_cr("MoveLine 1"):with_noremap():with_silent():with_desc("Move line down"),
    ["i|<C-S-Up>"] = map_cmd("<C-o>:MoveLine -1<CR>"):with_noremap():with_silent():with_desc("Move line up"),
    ["i|<C-S-Down>"] = map_cmd("<C-o>:MoveLine 1<CR>"):with_noremap():with_silent():with_desc("Move line down"),
    ["v|<C-S-Up>"] = map_cr("MoveBlock -1"):with_noremap():with_silent():with_desc("Move block up"),
    ["v|<C-S-Down>"] = map_cr("MoveBlock 1"):with_noremap():with_silent():with_desc("Move block down"),
})
