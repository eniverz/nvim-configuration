local bind = require("keymap.bind")
local map_callback = bind.map_callback
local map_cr = bind.map_cr

bind.nvim_load_mapping({
    ["nv|<leader>lf"] = map_callback(function()
            require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 500 })
        end)
        :with_silent()
        :with_noremap()
        :with_desc("conform: format"),
    ["n|<leader>ln"] = map_cr("ConformInfo"):with_silent():with_noremap():with_desc("conform: show format info"),
})
