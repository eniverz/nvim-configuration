local bind = require("keymap.bind")
local map_cmd = bind.map_cmd

bind.nvim_load_mapping({
    ["n|<leader>u|"] = map_cmd("<Cmd>IBLToggle<CR>"):with_silent():with_noremap():with_desc("indent blankline: toggle"),
})
