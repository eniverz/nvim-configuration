-- rainbow brackets
return {
    "hiphish/rainbow-delimiters.nvim",
    lazy = vim.fn.argc(-1) == 0,
    event = "BufReadPre",
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter",
            optional = true,
            opts = function(_, opts)
                if opts.ensure_installed ~= "all" then
                    opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "latex" })
                end
            end,
        },
    },
    opts = function()
        local rainbow = require("rainbow-delimiters")
        return {
            strategy = {
                [''] = rainbow.strategy["global"],
            },
            query = {
                [""] = "rainbow-delimiters",
                latex = "rainbow-blocks",
                javascript = "rainbow-delimiters-react",
                javascriptreact = "rainbow-delimiters-react",
                tsx = "rainbow-delimiters-react",
                typescriptreact = "rainbow-delimiters-react",
            },
            highlight = {
                "RainbowDelimiterRed",
                "RainbowDelimiterOrange",
                "RainbowDelimiterYellow",
                "RainbowDelimiterGreen",
                "RainbowDelimiterBlue",
                "RainbowDelimiterCyan",
                "RainbowDelimiterViolet",
            },
        }
    end,
    config = function(_, opts)
        require("rainbow-delimiters.setup").setup(opts)
    end,
}
