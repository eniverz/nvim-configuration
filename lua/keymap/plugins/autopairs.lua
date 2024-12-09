local bind = require("keymap.bind")
local map_callback = bind.map_callback

bind.nvim_load_mapping({
    ["n|<leader>ua"] = map_callback(function()
            local autopairs = require("nvim-autopairs")
            if autopairs.state.disabled then
                autopairs.enable()
            else
                autopairs.disable()
            end
            require("config.settings").autopairs = autopairs.state.disabled
        end)
        :with_silent()
        :with_noremap()
        :with_desc("autopairs: toggle autopairs"),
})
