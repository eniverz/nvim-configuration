local bind = require("keymap.bind")
local map_cr = bind.map_cr

bind.nvim_load_mapping({
    ["n|<leader>lt"] = map_cr("TroubleToggle"):with_noremap():with_silent():with_desc("lsp: Toggle trouble list"),
    ["n|<leader>ll"] = map_cr("TroubleToggle lsp_references")
        :with_noremap()
        :with_silent()
        :with_desc("lsp: Show lsp references"),
    ["n|<leader>lD"] = map_cr("TroubleToggle document_diagnostics")
        :with_noremap()
        :with_silent()
        :with_desc("lsp: Show document diagnostics"),
    ["n|<leader>lw"] = map_cr("TroubleToggle workspace_diagnostics")
        :with_noremap()
        :with_silent()
        :with_desc("lsp: Show workspace diagnostics"),
    ["n|<leader>lq"] = map_cr("TroubleToggle quickfix")
        :with_noremap()
        :with_silent()
        :with_desc("lsp: Show quickfix list"),
    ["n|<leader>lL"] = map_cr("TroubleToggle loclist"):with_noremap():with_silent():with_desc("lsp: Show loclist"),
})
