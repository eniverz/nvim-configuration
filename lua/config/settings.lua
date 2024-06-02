local settings = {
    use_ssh = true,
    notifications = true,
    autopairs = true,
    gui_config = {
        font_name = "CodeNewRoman Nerd Font",
        font_size = 12,
    },
    large_buf = { size = 1024 * 500, lines = 10000 },
    sessions = {
        autosave = { last = true, cwd = true },
        ignore = {
            dirs = {},
            filetypes = { "gitcommit", "gitrebase" },
            buftypes = {},
        },
    },
}

return settings
