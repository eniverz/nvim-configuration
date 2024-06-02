-- auto close pairs
return {
    "windwp/nvim-autopairs",
    event = "User",
    opts = {
        check_ts = true,
        ts_config = { java = false },
        fast_wrap = {
            map = "<M-e>",
            chars = { "{", "[", "(", '"', "'" },
            pattern = ([[ [%'%"%)%>%]%)%}%,] ]]):gsub("%s+", ""),
            offset = 0,
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "PmenuSel",
            highlight_grey = "LineNr",
        },
    },
    config = function(...)
        require("plugins.config.autopairs")(...)
    end,
}
