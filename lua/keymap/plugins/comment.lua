local bind = require("keymap.bind")
local map_callback = bind.map_callback
local map_cmd = bind.map_cmd

local mapping = map_callback(function()
        return require("Comment.api").call(
            "toggle.linewise." .. (vim.v.count == 0 and "current" or "count_repeat"),
            "g@$"
        )()
    end)
    :with_silent()
    :with_expr()
    :with_desc("Toggle comment line")

local x_mapping = map_cmd("<Esc><Cmd>lua require('Comment.api').locked('toggle.linewise')(vim.fn.visualmode())<CR>")
    :with_silent()
    :with_noremap()
    :with_desc("Toggle comment with selected line")

bind.nvim_load_mapping({
    ["n|<leader>/"] = mapping,
    ["n|<C-/>"] = mapping,
    ["n|<C-_>"] = mapping,

    ["x|<leader>/"] = x_mapping,
    ["xi|<C-/>"] = x_mapping,
    ["xi|<C-_>"] = x_mapping,
})
