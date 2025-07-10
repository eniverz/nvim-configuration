-- better help view
return {
    "OXY2DEV/helpview.nvim",
    event = "VeryLazy",
    keys = {
        { "<leader>uh", function()
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
        end, desc = "Helpview: toggle helpview preview" }
    }
}
