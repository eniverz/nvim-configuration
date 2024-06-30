-- show gitsigns
return {
    {
        "lewis6991/gitsigns.nvim",
        enabled = vim.fn.executable("git") == 1,
        event = { "CursorHold", "CursorHoldI" },
        opts = function()
            local mapping = require("keymap.plugins.gitsigns")
            return {
                signs = {
                    add = { text = "│" },
                    change = { text = "│" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                },
                on_attach = mapping,
                watch_gitdir = { interval = 1000, follow_files = true },
                current_line_blame = true,
                current_line_blame_opts = { delay = 1000, virtual_text_pos = "eol" },
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil, -- Use default
                word_diff = false,
                diff_opts = { internal = true },
            }
        end,
    },
    {
        "catppuccin",
        optional = true,
        ---@type CatppuccinOptions
        opts = {
            integrations = { gitsigns = true },
        },
    },
}
