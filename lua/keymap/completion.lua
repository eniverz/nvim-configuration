local bind = require("keymap.bind")

local mapping = {}

--- create on_attach function for lspconfig
---@param bufnr number
function mapping.on_attach(bufnr)
    bind.nvim_load_mapping(require("keymap.plugins.lspconfig")(bufnr))
    bind.nvim_load_mapping(require("keymap.plugins.lspsaga")(bufnr))
end

return mapping
