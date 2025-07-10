-- search and replace
return {
    "chrisgrieser/nvim-rip-substitute",
    cmd = "RipSubstitute",
    opts = {
        popupWin = {
            border = "rounded",
            position = "top",
        },
        prefill = { visual = false },
        keymaps = { abort = "<Esc>" },
    },
    keys = {
        {
            "<leader>fr",
            function()
                require("rip-substitute").sub()
            end,
            mode = { "n", "x" },
            desc = "RipSubstitute",
        },
    },
}
