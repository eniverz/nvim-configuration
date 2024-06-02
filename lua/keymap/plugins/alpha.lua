local bind = require("keymap.bind")

local map_callback = bind.map_callback

bind.nvim_load_mapping({
    ["n|<leader>h"] = map_callback(function()
            local wins = vim.api.nvim_tabpage_list_wins(0)
            if #wins > 1 and vim.bo[vim.api.nvim_win_get_buf(wins[1])].filetype == "neo-tree" then
                vim.fn.win_gotoid(wins[2])
            end
            require("alpha").start(false)
        end)
        :with_silent()
        :with_noremap()
        :with_desc("Alpha: Home Screen"),
})
