local bind = require("keymap.bind")
local map_callback = bind.map_callback

bind.nvim_load_mapping({
    ["n|<leader>uh"] = map_callback(function()
            local helpview = require("helpview")
            local first = next(helpview.state.buffer_states)
            if not first then
                vim.notify("No helpview buffer attached", vim.log.levels.INFO)
                return
            end
            if helpview.state.buffer_states[first].enable then
                helpview.commands["Disable"]()
                vim.notify("Disable Helpview", vim.log.levels.WARN)
            else
                helpview.commands["Enable"]()
                vim.notify("Enable Helpview", vim.log.levels.INFO)
            end
        end)
        :with_silent()
        :with_nowait()
        :with_noremap()
        :with_desc("Toggle helpview preview"),
})
