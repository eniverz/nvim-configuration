local bind = require("keymap.bind")
local map_cu = bind.map_cu

bind.nvim_load_mapping({
    ["n|<leader>sr"] = map_cu("RemoteSSHFSConnect"):with_noremap():with_silent():with_desc("remote: connect"),
    ["n|<leader>sd"] = map_cu("RemoteSSHFSDisonnect"):with_noremap():with_silent():with_desc("remote: disconnect"),
    ["n|<leader>sR"] = map_cu("RemoteSSHFSReload"):with_noremap():with_silent():with_desc("remote: reload"),
})
