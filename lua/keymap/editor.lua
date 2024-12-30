local bind = require("keymap.bind")
local map_cmd = bind.map_cmd
local map_cr = bind.map_cr
local map_callback = bind.map_callback

bind.nvim_load_mapping({
    -- change delete keymap
    ["nv|d"] = map_cmd('"_d'):with_noremap():with_silent():with_nowait():with_desc("edit: change clipboard register for delete"),
    ["nv|D"] = map_cmd('"_D'):with_noremap():with_silent():with_nowait():with_desc("edit: change clipboard register for delete"),
    ["nv|s"] = map_cmd('"_s'):with_noremap():with_silent():with_nowait():with_desc("edit: change clipboard register for delete"),
    ["nv|S"] = map_cmd('"_S'):with_noremap():with_silent():with_nowait():with_desc("edit: change clipboard register for delete"),
    ["nv|c"] = map_cmd('"_c'):with_noremap():with_silent():with_nowait():with_desc("edit: change clipboard register for delete"),
    ["nv|C"] = map_cmd('"_C'):with_noremap():with_silent():with_nowait():with_desc("edit: change clipboard register for delete"),

    -- delete
    ["n|<C-Backspace>"] = map_cmd('"_db'):with_noremap():with_silent():with_nowait():with_desc("edit: Delete word forward"),
    ["i|<C-Backspace>"] = map_cmd('<C-o>"_db'):with_noremap():with_silent():with_nowait():with_desc("edit: Delete word forward"),
    ["n|<C-Del>"] = map_cmd('"_dw'):with_noremap():with_silent():with_nowait():with_desc("edit: Delete word backward"),
    ["i|<C-Del>"] = map_cmd('<C-o>"_dw'):with_noremap():with_silent():with_nowait():with_desc("edit: Delete word backward"),

    -- buffer operations
    ["n|<leader>q"] = map_cmd("<Cmd>confirm q<CR>"):with_noremap():with_silent():with_nowait():with_desc("edit: force quit"),

    -- indent
    ["v|<S-Tab>"] = map_cmd("<gv"):with_desc("edit: Decrease indent"),
    ["v|<Tab>"] = map_cmd(">gv"):with_desc("edit: Increase indent"),
    ["n|<leader>lF"] = map_cr("normal! gg=G``"):with_noremap():with_silent():with_desc("format indent"),

    -- buffer
    ["ni|<C-s>"] = map_cmd("<Esc><Esc><Esc>:w<CR>"):with_desc("edit: Save file"),

    -- line
    ["i|<C-CR>"] = map_cmd("<C-o>o"):with_silent():with_noremap():with_nowait():with_desc("edit: new line"),
    ["i|<S-CR>"] = map_cmd("<C-o>o"):with_silent():with_noremap():with_nowait():with_desc("edit: new line"),
    ["n|<C-d>"] = map_cr("copy ."):with_silent():with_noremap():with_nowait():with_desc("edit: duplicate line"),
    ["i|<C-d>"] = map_cmd("<Esc><Esc><Cmd>copy .<CR>i"):with_silent():with_noremap():with_nowait():with_desc("edit: duplicate line"),
    ["v|<C-d>"] = map_cr("copy '>"):with_silent():with_noremap():with_nowait():with_desc("edit: duplicate line"),

    -- history
    ["n|r"] = map_cr("redo"):with_noremap():with_silent():with_nowait():with_desc("edit: Redo"),
    ["n|u"] = map_cr("undo"):with_noremap():with_silent():with_nowait():with_desc("edit: Undo"),

    -- jump cursor position
    ["n|<A-S-Left>"] = map_cmd("<C-o>"):with_noremap():with_silent():with_nowait():with_desc("edit: jump cursor position"),
    ["n|<A-S-Right>"] = map_cmd("<C-i>"):with_noremap():with_silent():with_nowait():with_desc("edit: jump cursor position"),

    -- search
    ["n|<Esc>"] = map_callback(function()
            pcall(vim.cmd.noh)
        end)
        :with_noremap()
        :with_silent()
        :with_nowait()
        :with_desc("edit: Clear search highlight"),
})
