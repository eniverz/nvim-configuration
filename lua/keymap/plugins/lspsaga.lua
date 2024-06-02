return function(buf)
    local map_cr = require("keymap.bind").map_cr
    local map_callback = require("keymap.bind").map_callback
    return {
        ["n|<leader>l["] = map_cr("Lspsaga diagnostic_jump_prev")
            :with_silent()
            :with_buffer(buf)
            :with_desc("lsp: Prev diagnostic"),
        ["n|<leader>l]"] = map_cr("Lspsaga diagnostic_jump_next")
            :with_silent()
            :with_buffer(buf)
            :with_desc("lsp: Next diagnostic"),
        ["n|<leader>lx"] = map_cr("Lspsaga show_line_diagnostics ++unfocus")
            :with_silent()
            :with_buffer(buf)
            :with_desc("lsp: Line diagnostic"),
        ["n|<leader>lh"] = map_callback(function()
            vim.lsp.buf.signature_help()
        end):with_desc("lsp: Signature help"),
        ["n|<leader>lr"] = map_cr("Lspsaga rename")
            :with_silent()
            :with_buffer(buf)
            :with_desc("lsp: Rename in file range"),
        ["n|<leader>lR"] = map_cr("Lspsaga rename ++project")
            :with_silent()
            :with_buffer(buf)
            :with_desc("lsp: Rename in project range"),
        ["n|<leader>lk"] = map_cr("Lspsaga hover_doc"):with_silent():with_buffer(buf):with_desc("lsp: Show doc"),
        ["nv|<leader>la"] = map_cr("Lspsaga code_action")
            :with_silent()
            :with_buffer(buf)
            :with_desc("lsp: Code action for cursor"),

        ["n|gD"] = map_cr("Lspsaga goto_definition"):with_silent():with_buffer(buf):with_desc("lsp: Goto definition"),
    }
end
