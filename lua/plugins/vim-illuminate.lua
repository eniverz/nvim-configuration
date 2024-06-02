return {
    "RRethy/vim-illuminate",
    event = { "CursorHold", "CursorHoldI" },
    opts = function()
        return {
            providers = {
                "lsp",
                "treesitter",
                "regex",
            },
            delay = 100,
            filetypes_denylist = {
                "DoomInfo",
                "DressingSelect",
                "NvimTree",
                "TelescopePrompt",
                "Trouble",
                "aerial",
                "alpha",
                "dashboard",
                "dirvish",
                "fugitive",
                "help",
                "neogitstatus",
                "norg",
                "toggleterm",
            },
            under_cursor = false,
            large_file_overrides = { providers = { "lsp" } },
            should_enable = function(bufnr)
                return require("utils.core").is_valid(bufnr)
            end,
        }
    end,
    config = function(_, opts)
        require("illuminate").configure(opts)
    end,
}
