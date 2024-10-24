local bind = require("keymap.bind")
local map_cr = bind.map_cr

bind.nvim_load_mapping({
    ["n|<leader>ot"] = map_cr("OverseerToggle"):with_noremap():with_silent():with_desc("overseer: Toggle"),
    ["n|<leader>or"] = map_cr("OverseerRun"):with_noremap():with_silent():with_desc("overseer: Run"),
})
