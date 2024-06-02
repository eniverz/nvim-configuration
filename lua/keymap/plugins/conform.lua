local bind = require("keymap.bind")
local map_callback = bind.map_callback

bind.nvim_load_mapping({
    ["nv|<leader>lf"] = map_callback(function ()
            require("conform").format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 500
            })
        end)
        :with_silent()
        :with_noremap()
        :with_desc("conform: format")
})
