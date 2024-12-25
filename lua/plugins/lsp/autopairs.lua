-- auto close pairs
return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
        check_ts = true,
        -- ts_config = { java = false },
        fast_wrap = {
            map = "<A-e>",
            chars = { "{", "[", "(", '"', "'", "<" },
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
        local cond = require("nvim-autopairs.conds")
        local Rule = require("nvim-autopairs.rule")
        npairs.setup(opts)
        npairs.add_rules({
            Rule("$", "$", { "tex", "latex" })
                -- don't add a pair if the next character is %
                :with_pair(cond.not_after_regex("%%"))
                -- don't add a pair if  the previous character is xxx
                :with_pair(cond.not_before_regex("xxx", 3))
                -- don't move right when repeat character
                :with_move(cond.none())
                -- don't delete if the next character is xx
                :with_del(cond.not_after_regex("xx"))
                -- disable adding a newline when you press <cr>
                :with_cr(cond.none()),
        }, {
            Rule("$$", "$$", "tex"):with_pair(function(opt)
                if opt.line == "aa $$" then
                    -- don't add pair on that line
                    return false
                end
            end),
        })

        if not require("config.settings").lsp.features.autopairs then
            npairs.disable()
        end
    end,
}
