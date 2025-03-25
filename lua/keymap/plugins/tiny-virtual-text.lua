local bind = require("keymap.bind")
local map_callback = bind.map_callback

bind.nvim_load_mapping({
    ["n|<leader>uD"] = map_callback(function()
            local tinyDiagnostics = require("tiny-inline-diagnostic")
            local toggleDiagnostics = Snacks.toggle.diagnostics()
            if toggleDiagnostics:get() then
                tinyDiagnostics.disable()
            else
                tinyDiagnostics.enable()
            end
            toggleDiagnostics:toggle()
        end)
        :with_silent()
        :with_noremap()
        :with_nowait()
        :with_desc("Toggle Diagnostics"),
})
