local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_callback = bind.map_callback

bind.nvim_load_mapping({
    ["v|<leader>r"] = map_cr("SnipRun"):with_silent():with_noremap():with_desc("SnipRun: run code by range"),
    ["n|<leader>r"] = map_callback(function()
            require("sniprun").reset()
            require("sniprun").run("n")
        end)
        :with_silent()
        :with_noremap()
        :with_desc("SnipRun: run code"),
})
