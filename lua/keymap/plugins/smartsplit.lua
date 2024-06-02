local bind = require("keymap.bind")
local map_callback = bind.map_callback

bind.nvim_load_mapping({
    ["n|<C-H>"] = map_callback(function()
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
    ["n|<C-L>"] = map_callback(function()
            require("smart-splits").move_cursor_right()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("smart-split: move cursor right"),
    -- maps.n["<C-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" }
    -- maps.n["<C-Down>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" }
    -- maps.n["<C-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" }
    -- maps.n["<C-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" }
})
