-- automatically disables certain features if the opened file is big
return {
    "LunarVim/bigfile.nvim",
    lazy = false,
    config = function()
        local ftdetect = {
            name = "ftdetect",
            opts = { defer = true },
            disable = function()
                vim.api.nvim_set_option_value("filetype", "big_file_disabled_ft", { scope = "local" })
            end,
        }

        local cmp = {
            name = "nvim-cmp",
            opts = { defer = true },
            disable = function()
                require("cmp").setup.buffer({ enabled = false })
            end,
        }

        require("bigfile").setup({
            filesize = 1, -- size of the file in MiB
            pattern = { "*" }, -- autocmd pattern
            features = { -- features to disable
                "lsp",
                "illuminate",
                "treesitter",
                "syntax",
                "vimopts",
                ftdetect,
                cmp,
            },
        })
    end,
    cond = require("config.settings").load_big_files_faster,
}
