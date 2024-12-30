-- easy move lines and blocks of code up and down
return {
    "fedepujol/move.nvim",
    cmd = { "MoveLine", "MoveBlock", "MoveHBlock" },
    opts = { char = { enable = true } },
}
