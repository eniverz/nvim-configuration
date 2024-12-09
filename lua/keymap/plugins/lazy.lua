local bind = require("keymap.bind")
local map_cr = bind.map_cr

bind.nvim_load_mapping({
    -- Package manager: lazy.nvim
    ["n|<leader>pl"] = map_cr("Lazy"):with_silent():with_noremap():with_nowait():with_desc("package: Show lazy"),
    ["n|<leader>pc"] = map_cr("Lazy check"):with_silent():with_noremap():with_nowait():with_desc("package: Check"),
    ["n|<leader>pu"] = map_cr("Lazy update"):with_silent():with_noremap():with_nowait():with_desc("package: Update"),
    ["n|<leader>pp"] = map_cr("Lazy profile"):with_silent():with_noremap():with_nowait():with_desc("package: Profile"),
})
