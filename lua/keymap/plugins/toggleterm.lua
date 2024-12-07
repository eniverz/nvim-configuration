local bind = require("keymap.bind")
local map_cmd = bind.map_cmd
local map_cr = bind.map_cr

bind.nvim_load_mapping({
    ["t|<Esc><Esc>"] = map_cmd([[<C-\><C-n>]]):with_noremap():with_silent(), -- switch to normal mode in terminal.
    ["n|<leader>th"] = map_cr("ToggleTerm direction=horizontal"):with_noremap():with_silent():with_desc("terminal: Toggle horizontal"),
    ["i|<F4>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=horizontal<CR>"):with_noremap():with_silent():with_desc("terminal: Toggle horizontal"),
    ["t|<F4>"] = map_cmd("<Cmd>ToggleTerm<CR>"):with_noremap():with_silent():with_desc("terminal: Toggle horizontal"),
    ["n|<leader>tv"] = map_cr("ToggleTerm direction=vertical"):with_noremap():with_silent():with_desc("terminal: Toggle vertical"),
    ["i|<F3>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=vertical<CR>"):with_noremap():with_silent():with_desc("terminal: Toggle vertical"),
    ["t|<F3>"] = map_cmd("<Cmd>ToggleTerm<CR>"):with_noremap():with_silent():with_desc("terminal: Toggle vertical"),
    ["n|<leader>tf"] = map_cr("ToggleTerm direction=float"):with_noremap():with_silent():with_desc("terminal: Toggle float"),
    ["n|<F2>"] = map_cr("ToggleTerm direction=float"):with_noremap():with_silent():with_desc("terminal: Toggle float"),
    ["i|<F2>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=float<CR>"):with_noremap():with_silent():with_desc("terminal: Toggle float"),
    ["t|<A-d>"] = map_cmd("<Cmd>ToggleTerm<CR>"):with_noremap():with_silent():with_desc("terminal: Toggle float"),
})
