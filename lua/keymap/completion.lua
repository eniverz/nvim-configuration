local bind = require("keymap.bind")
local map_cmd = bind.map_cmd

local plug_map = {
    ["n|<A-f>"] = map_cmd("<Cmd>FormatToggle<CR>"):with_noremap():with_desc("Formater: Toggle format on save"),
}
bind.nvim_load_mapping(plug_map)

local aerial = require("keymap.plugins.aerial")
local lspconfig = require("keymap.plugins.lspconfig")
local lspsaga = require("keymap.plugins.lspsaga")
local glance = require("keymap.plugins.glance")

local mapping = {}

function mapping.lsp(buf)
    bind.nvim_load_mapping(aerial(buf))
    bind.nvim_load_mapping(lspconfig(buf))
    bind.nvim_load_mapping(lspsaga(buf))
    bind.nvim_load_mapping(glance(buf))
end

return mapping
