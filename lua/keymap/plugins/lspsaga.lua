local map_cr = require("keymap.bind").map_cr

--- create on_attach function for lspsaga
---@param bufnr number
return function(bufnr)
    return {
        ["n|<leader>lr"] = map_cr("Lspsaga rename"):with_silent():with_buffer(bufnr):with_desc("lsp: Rename in file range"),
        ["n|<leader>lR"] = map_cr("Lspsaga rename ++project"):with_silent():with_buffer(bufnr):with_desc("lsp: Rename in project range"),
        ["n|<leader>lk"] = map_cr("Lspsaga hover_doc"):with_silent():with_buffer(bufnr):with_desc("lsp: Show doc"),
        ["nv|<leader>la"] = map_cr("Lspsaga code_action"):with_silent():with_buffer(bufnr):with_desc("lsp: Code action for cursor"),
        ["n|<leader>ld"] = map_cr("Lspsaga peek_definition"):with_silent():with_buffer(bufnr):with_desc("lsp: peek definition under cursor"),
        ["n|<leader>lD"] = map_cr("Lspsaga goto_definition"):with_silent():with_buffer(bufnr):with_desc("lsp: goto definition for cursor"),
        ["n|<leader>ls"] = map_cr("Lspsaga outline"):with_silent():with_buffer(bufnr):with_desc("lsp: show symbol outline"),
        -- diagnostic
        ["n|<leader>xj"] = map_cr("Lspsaga diagnostic_jump_next"):with_silent():with_buffer(bufnr):with_desc("lspsaga: goto next diagnostic"),
        ["n|<leader>xk"] = map_cr("Lspsaga diagnostic_jump_prev"):with_silent():with_buffer(bufnr):with_desc("lspsaga: goto prev diagnostic"),
        ["n|<leader>xx"] = map_cr("Lspsaga show_buf_diagnostics"):with_silent():with_buffer(bufnr):with_desc("lspsaga: show diagnostics on current buffer"),
        ["n|<leader>xX"] = map_cr("Lspsaga show_workspace_diagnostics"):with_silent():with_buffer(bufnr):with_desc("lspsaga: show diagnostics on workspace"),
    }
end
