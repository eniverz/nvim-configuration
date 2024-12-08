local bind = require("keymap.bind")

local mapping = {}

--- create on_attach function for lspconfig
---@param bufnr number
function mapping.on_attach(bufnr)
    bind.nvim_load_mapping(require("keymap.plugins.lspconfig")(bufnr))
end

return mapping
