local bind = require("keymap.bind")
local map_cr = bind.map_cr

bind.nvim_load_mapping({
    ["n|<leader>gd"] = map_cr("DiffviewFileHistory"):with_noremap():with_nowait():with_silent():with_desc("Diff view: open file history"),
    ["n|<leader>gD"] = map_cr("DiffviewOpen"):with_noremap():with_nowait():with_silent():with_desc("Diff view: open file diff in current work tree"),
})
