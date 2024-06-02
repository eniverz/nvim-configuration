local bind = require("keymap.bind")
local map_cu = bind.map_cu

bind.nvim_load_mapping({
    ["n|<leader>lc"] = map_cu("CondaActivate"):with_noremap():with_silent():with_desc("conda: show activate env"),
    ["n|<leader>ld"] = map_cu("CondaDeactivate")
        :with_noremap()
        :with_silent()
        :with_desc("conda: deactivate current env"),
})
