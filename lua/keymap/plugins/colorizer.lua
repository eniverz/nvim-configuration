local bind = require("keymap.bind")
local map_cmd = bind.map_cmd

bind.nvim_load_mapping({
    ["n|<leader>uc"] = map_cmd("<Cmd>ColorizerToggle<CR>")
        :with_silent()
        :with_noremap()
        :with_desc("Colorizer: Toggle color highlight"),
})
