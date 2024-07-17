local bind = require("keymap.bind")
local map_cmd = bind.map_cmd
local map_cr = bind.map_cr
local map_callback = bind.map_callback

bind.nvim_load_mapping({
    -- delete
    ["n|<C-H>"] = map_cmd('"_db'):with_noremap():with_silent():with_nowait():with_desc("edit: Delete word forward"),
    ["i|<C-H>"] = map_cmd('<C-o>"_db')
        :with_noremap()
        :with_silent()
        :with_nowait()
        :with_desc("edit: Delete word forward"),
    ["n|<C-Del>"] = map_cmd('"_dw'):with_noremap():with_silent():with_nowait():with_desc("edit: Delete word backward"),
    ["i|<C-Del>"] = map_cmd('<C-o>"_dw')
        :with_noremap()
        :with_silent()
        :with_nowait()
        :with_desc("edit: Delete word backward"),

    -- buffer operations
    ["n|<leader>q"] = map_cmd("<Cmd>confirm q<CR>")
        :with_noremap()
        :with_silent()
        :with_nowait()
        :with_desc("edit: force quit"),
    ["n|<leader>N"] = map_cmd("<Cmd>enew<CR>")
        :with_noremap()
        :with_silent()
        :with_nowait()
        :with_desc("edit: create new file"),
    ["n|<leader>c"] = map_callback(function()
            require("utils.buffer").close()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("edit: close current buffer"),
    ["n|<leader>bc"] = map_callback(function()
            require("utils.buffer").close_all(true)
        end)
        :with_silent()
        :with_noremap()
        :with_desc("edit: close all except current buffer"),
    ["n|<leader>bl"] = map_callback(function()
            require("utils.buffer").close_left()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("edit: close all buffer at left"),
    ["n|<leader>br"] = map_callback(function()
            require("utils.buffer").close_right()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("edit: close all buffer at right"),
    ["n|<leader>bC"] = map_callback(function()
            require("utils.buffer").close_all()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("edit: close all buffers"),

    -- indent
    ["v|<S-Tab>"] = map_cmd("<gv"):with_desc("edit: Decrease indent"),
    ["v|<Tab>"] = map_cmd(">gv"):with_desc("edit: Increase indent"),
    ["n|<leader>lF"] = map_cmd("<Cmd>normal! gg=G``<CR>"):with_noremap():with_silent():with_desc("format indent"),

    -- buffer
    ["ni|<C-s>"] = map_cmd("<Esc><Esc><Esc>:w<CR>"):with_desc("edit: Save file"),
    ["n|<C-w>"] = map_callback(function()
            require("utils.buffer").close()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("edit: close current buffer"),

    -- line
    ["i|<C-CR>"] = map_cmd("<C-o>o"):with_silent():with_noremap():with_nowait():with_desc("edit: new line"),
    ["i|<S-CR>"] = map_cmd("<C-o>o"):with_silent():with_noremap():with_nowait():with_desc("edit: new line"),
    ["n|<C-d>"] = map_cr("copy ."):with_silent():with_noremap():with_nowait():with_desc("edit: duplicate line"),
    ["i|<C-d>"] = map_cmd("<Esc><Esc><Cmd>copy .<CR>i")
        :with_silent()
        :with_noremap()
        :with_nowait()
        :with_desc("edit: duplicate line"),
    ["v|<C-d>"] = map_cr("copy '>"):with_silent():with_noremap():with_nowait():with_desc("edit: duplicate line"),

    ["n|<C-S-down>"] = map_cmd("<Cmd>m+<CR>==")
        :with_silent()
        :with_noremap()
        :with_nowait()
        :with_desc("edit: move line down"),
    ["n|<C-S-up>"] = map_cmd("<Cmd>m-2<CR>==")
        :with_silent()
        :with_noremap()
        :with_nowait()
        :with_desc("edit: move line up"),
    ["i|<C-S-up>"] = map_cmd("<C-o><Cmd>m-2<CR>")
        :with_silent()
        :with_noremap()
        :with_nowait()
        :with_desc("edit: move line up"),
    ["i|<C-S-down>"] = map_cmd("<C-o><Cmd>m+<CR>")
        :with_silent()
        :with_noremap()
        :with_nowait()
        :with_desc("edit: move line down"),
    ["v|<C-S-up>"] = map_cmd("<Cmd>'<,'>m-2<CR>gv=gv")
        :with_silent()
        :with_noremap()
        :with_nowait()
        :with_desc("edit: move line up"),
    ["v|<C-S-down>"] = map_cmd("<Cmd>m'>+<CR>gv=gv")
        :with_silent()
        :with_noremap()
        :with_nowait()
        :with_desc("edit: move line down"),

    -- history
    ["n|r"] = map_cr("redo"):with_noremap():with_silent():with_nowait():with_desc("edit: Redo"),
    ["n|u"] = map_cr("undo"):with_noremap():with_silent():with_nowait():with_desc("edit: Undo"),

    -- search
    ["n|<Esc>"] = map_callback(function()
            pcall(vim.cmd.noh)
        end)
        :with_noremap()
        :with_silent()
        :with_nowait()
        :with_desc("edit: Clear search highlight"),
})
