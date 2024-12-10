-- auto setup indent for different file
return {
    "NMAC427/guess-indent.nvim",
    cmd = { "GuessIndent" },
    opts = {
        filetype_exclude = { "big_file_disabled_ft" },
    },
    config = function(_, opts)
        require("guess-indent").setup(opts)
        vim.cmd.lua({ args = { "require('guess-indent').set_from_buffer('auto_cmd')" }, mods = { silent = true } })
    end,
}
