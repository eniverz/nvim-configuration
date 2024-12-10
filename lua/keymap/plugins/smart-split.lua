local bind = require("keymap.bind")
local map_callback = bind.map_callback

local move_cursor_left = map_callback(function()
        require("smart-splits").move_cursor_left()
    end)
    :with_silent()
    :with_noremap()
    :with_desc("smart-split: move cursor left")
local move_cursor_right = map_callback(function()
        require("smart-splits").move_cursor_right()
    end)
    :with_silent()
    :with_noremap()
    :with_desc("smart-split: move cursor right")
local move_cursor_up = map_callback(function()
        require("smart-splits").move_cursor_up()
    end)
    :with_silent()
    :with_noremap()
    :with_desc("smart-split: move cursor up")
local move_cursor_down = map_callback(function()
        require("smart-splits").move_cursor_down()
    end)
    :with_silent()
    :with_noremap()
    :with_desc("smart-split: move cursor down")
local resize_left = map_callback(function()
        require("smart-splits").resize_left()
    end)
    :with_silent()
    :with_noremap()
    :with_desc("smart-split: resize split left")
local resize_right = map_callback(function()
        require("smart-splits").resize_right()
    end)
    :with_silent()
    :with_noremap()
    :with_desc("smart-split: resize split right")
local resize_up = map_callback(function()
        require("smart-splits").resize_up()
    end)
    :with_silent()
    :with_noremap()
    :with_desc("smart-split: resize split up")
local resize_down = map_callback(function()
        require("smart-splits").resize_down()
    end)
    :with_silent()
    :with_noremap()
    :with_desc("smart-split: resize split down")

bind.nvim_load_mapping({
    -- jump
    ["n|<leader>wl"] = move_cursor_left,
    ["n|<C-L>"] = move_cursor_left,
    ["n|<leader>wj"] = move_cursor_down,
    ["n|<C-J>"] = move_cursor_down,
    ["n|<leader>wk"] = move_cursor_up,
    ["n|<C-K>"] = move_cursor_up,
    ["n|<leader>wh"] = move_cursor_right,
    ["n|<C-H>"] = move_cursor_right,
    --resize
    ["n|<leader>wr"] = map_callback(function()
            require("smart-splits").start_resize_mode()
        end)
        :with_noremap()
        :with_silent()
        :with_desc("smart-split: resize split"),
})
