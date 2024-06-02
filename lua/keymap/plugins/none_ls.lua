local bind = require("keymap.bind")
local map_callback = bind.map_callback
local map_cmd = bind.map_cmd

bind.nvim_load_mapping({
    ["n|<leader>ln"] = map_cmd("<Cmd>NullLsInfo<CR>"):with_silent():with_noremap():with_desc("lsp: null-ls info"),
    ["n|<leader>lf"] = map_callback(function ()
        vim.lsp.buf.format()
    end):with_silent():with_noremap():with_desc("lsp: format")
})
