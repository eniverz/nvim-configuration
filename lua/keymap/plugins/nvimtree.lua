local bind = require("keymap.bind")
local map_cr = bind.map_cr

bind.nvim_load_mapping({
    ["n|<leader>e"] = map_cr("NvimTreeToggle"):with_noremap():with_silent():with_desc("filetree: Toggle"),
    ["n|<leader>nf"] = map_cr("NvimTreeFindFile"):with_noremap():with_silent():with_desc("filetree: Find file"),
    ["n|<leader>nr"] = map_cr("NvimTreeRefresh"):with_noremap():with_silent():with_desc("filetree: Refresh"),
    ["n|<leader>ne"] = map_cr("NvimTreeOpen"):with_noremap():with_silent():with_desc("filetree: Focus/Open"),
    ["n|<leader>o"] = map_cr("NvimTreeOpen"):with_noremap():with_silent():with_desc("filetree: Focus/Open"),
})
