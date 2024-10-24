local bind = require("keymap.bind")
local map_cr = bind.map_cr

bind.nvim_load_mapping({
    ["n|<leader>Ot"] = map_cr("OverseerToggle"):with_noremap():with_silent():with_desc("overseer: Toggle"),
    ["n|<leader>Or"] = map_cr("OverseerRun"):with_noremap():with_silent():with_desc("overseer: Run"),
})
