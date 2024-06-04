local bind = require("keymap.bind")
local map_callback = bind.map_callback

bind.nvim_load_mapping({
    ["n|<C-9>"] = map_callback(function()
            require("smart-splits").move_cursor_left()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("smart-split: move cursor left"),
    ["n|<C-J>"] = map_callback(function()
            require("smart-splits").move_cursor_up()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("smart-split: move cursor up"),
    ["n|<C-K>"] = map_callback(function()
            require("smart-splits").move_cursor_down()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("smart-split: move cursor down"),
    ["n|<C-0>"] = map_callback(function()
            require("smart-splits").move_cursor_right()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("smart-split: move cursor right"),
    ["n|<C-(>"] = map_callback(function()
            require("smart-splits").resize_left()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("smart-split: resize split left"),
    ["n|<C-)>"] = map_callback(function()
            require("smart-splits").resize_right()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("smart-split: resize split right"),
    ["n|<S-Up>"] = map_callback(function()
            require("smart-splits").resize_up()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("smart-split: resize split up"),
    ["n|<S-Down>"] = map_callback(function()
            require("smart-splits").resize_down()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("smart-split: resize split down"),
})
