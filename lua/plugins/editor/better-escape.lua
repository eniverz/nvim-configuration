-- better performance for insert letter "j" and "k"
return {
    "max397574/better-escape.nvim",
    event = { "CursorHold", "CursorHoldI", "InsertCharPre" },
    opts = {
        timeout = 300,
        default_mappings = false,
        mappings = {
            i = { j = { j = "<Esc>" } },
            c = { j = { j = "<Esc>" } },
        },
    },
}
