local bind = require("keymap.bind")
local map_cr = bind.map_cr

bind.nvim_load_mapping({
    ["n|<leader>e"] = map_cr("Yazi"):with_noremap():with_silent():with_nowait():with_desc("Yazi: Toggle with current file"),
    ["n|<leader>n"] = map_cr("Yazi cwd"):with_noremap():with_silent():with_nowait():with_desc("Yazi: Toggle with current working directory"),
})
