local bind = require("keymap.bind")
local map_cr = bind.map_cr

bind.nvim_load_mapping({
    ["n|<leader>xX"] = map_cr("Trouble diagnostics toggle")
        :with_noremap()
        :with_silent()
        :with_desc("lsp: Show workspace diagnostics"),
    ["n|<leader>xx"] = map_cr("Trouble diagnostics toggle filter.buf=0")
        :with_noremap()
        :with_silent()
        :with_desc("lsp: Show diagnostics in current buf"),
    ["n|<leader>xl"] = map_cr("Trouble loclist toggle")
        :with_noremap()
        :with_silent()
        :with_desc("lsp: Show trouble location list"),
    ["n|<leader>xq"] = map_cr("Trouble quickfix toggle")
        :with_noremap()
        :with_silent()
        :with_desc("lsp: Show quickfix list"),
})
