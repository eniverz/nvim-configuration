return function(buf)
    local map_cr = require("keymap.bind").map_cr
    return {
        ["n|<leader>li"] = map_cr("LspInfo"):with_silent():with_buffer(buf):with_desc("lsp: Info"),
        ["n|<leader>lS"] = map_cr("LspRestart"):with_silent():with_buffer(buf):with_nowait():with_desc("lsp: Restart"),
    }
end
