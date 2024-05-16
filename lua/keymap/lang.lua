local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
-- local map_cmd = bind.map_cmd
-- local map_callback = bind.map_callback

local plug_map = {
    -- Plugin MarkdownPreview
    ["n|<F12>"] = map_cr("MarkdownPreviewToggle"):with_noremap():with_silent():with_desc("tool: Preview markdown"),
    -- Plugin for conda
    ["n|<leader>lc"] = map_cu("CondaActivate"):with_noremap():with_silent():with_desc("conda: show activate env"),
    ["n|<leader>ld"] = map_cu("CondaDeactivate"):with_noremap():with_silent():with_desc("conda: deactivate current env"),
}

bind.nvim_load_mapping(plug_map)
