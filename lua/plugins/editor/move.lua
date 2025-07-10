-- easy move lines and blocks of code up and down
return {
    "fedepujol/move.nvim",
    cmd = { "MoveLine", "MoveBlock", "MoveHBlock" },
    opts = { char = { enable = true } },
    keys = {
        {"<C-S-Up>", "<Cmd>MoveLine -1<CR>", desc = "Move: move line up"},
        {"<C-S-Down>", "<Cmd>MoveLine 1<CR>", desc = "Move: move line down"},
        {"<C-S-Up>", "<C-o><Cmd>MoveLine -1<CR>", mode = "i", desc = "Move: move line up"},
        {"<C-S-Down>", "<C-o><Cmd>MoveLine 1<CR>", mode = "i", desc = "Move: move line down"},
        {"<C-S-Up>", ":MoveBlock -1<CR>", mode = "v", desc = "Move: move block up"},
        {"<C-S-Down>", ":MoveBlock 1<CR>", mode = "v", desc = "Move: move block down"},
    },
}
