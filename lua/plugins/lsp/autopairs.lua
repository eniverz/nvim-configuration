-- auto close pairs
return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
        check_ts = true,
        -- ts_config = { java = false },
        fast_wrap = {
            map = "<A-e>",
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
    config = function(_, opts)
        local npairs = require("nvim-autopairs")
        npairs.setup(opts)

        if not require("config.settings").lsp.features.autopairs then
            npairs.disable()
        end
    end,
}
