local map_cr = require("keymap.bind").map_cr

---@param bufnr number
return function(bufnr)
    return {
        ["n|<leader>li"] = map_cr("LspInfo"):with_noremap():with_buffer(bufnr):with_silent():with_desc("Lsp: Show info"),
        ["n|<leader>lS"] = map_cr("LspStart"):with_noremap():with_buffer(bufnr):with_silent():with_desc("Lsp: Start")
    }
end
