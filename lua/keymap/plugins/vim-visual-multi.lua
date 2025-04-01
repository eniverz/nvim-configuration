local bind = require("keymap.bind")
local map_cmd = bind.map_cmd

bind.nvim_load_mapping({
    ["n|<A-Down>"] = map_cmd("<Plug>(VM-Add-Cursor-Down)"):with_nowait():with_noremap():with_silent():with_desc("Add cursor down"),
    ["n|<A-Up>"] = map_cmd("<Plug>(VM-Add-Cursor-Up)"):with_nowait():with_noremap():with_silent():with_desc("Add cursor up"),
})
