local bind = require("keymap.bind")
local map_cmd = bind.map_cmd
local map_cr = bind.map_cr

bind.nvim_load_mapping({
    ["n|<leader>fT"] = map_cmd("<Cmd>TodoTelescope<CR>"):with_silent():with_noremap():with_desc("find: todos"),
    ["n|<leader>xt"] = map_cr("TodoTrouble"):with_noremap():with_silent():with_desc("todo: show trouble todo list"),
    ["n|<leader>xT"] = map_cr("TodoTrouble keywords=TODO,FIX,FIXME"):with_noremap():with_silent():with_desc("todo: show todo/fixme/fix"),
})
