local bind = require("keymap.bind")
local map_cr = bind.map_cr

return function(buf)
    return {
        ["n|gd"] = map_cr("Glance definitions"):with_silent():with_buffer(buf):with_desc("lsp: Preview definition"),
        ["n|gh"] = map_cr("Glance references"):with_silent():with_buffer(buf):with_desc("lsp: Show reference"),
    }
end
