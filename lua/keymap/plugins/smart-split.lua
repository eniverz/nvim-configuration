local bind = require("keymap.bind")
local map_callback = bind.map_callback

bind.nvim_load_mapping({
    -- jump
    ["n|<leader>wl"] = map_callback(function()
            require("smart-splits").move_cursor_left()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("smart-split: move cursor left"),
    ["n|<leader>wj"] = map_callback(function()
            require("smart-splits").move_cursor_right()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("smart-split: move cursor right"),
    ["n|<leader>wk"] = map_callback(function()
            require("smart-splits").move_cursor_up()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("smart-split: move cursor up"),
    ["n|<leader>wh"] = map_callback(function()
            require("smart-splits").move_cursor_down()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("smart-split: move cursor down"),
    --resize
    ["n|<leader>wr"] = map_callback(function()
            require("smart-splits").start_resize_mode()
        end)
        :with_noremap()
        :with_silent()
        :with_desc("smart-split: resize split"),
})
