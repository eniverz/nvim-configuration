local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_callback = bind.map_callback

bind.nvim_load_mapping({
    ["n|<leader>or"] = map_callback(function()
            require("overseer").run_template({})
        end)
        :with_noremap()
        :with_silent()
        :with_desc("Overseer: run task"),
    ["n|<leader>oc"] = map_cr("OverseerRunCmd"):with_noremap():with_silent():with_desc("Overseer: run command"),
    ["n|<leader>ot"] = map_cr("OverseerToggle"):with_noremap():with_silent():with_desc("Overseer: toggle task list"),
    ["n|<leader>oi"] = map_cr("OverseerInfo"):with_noremap():with_silent():with_desc("Overseer: show info"),
})
