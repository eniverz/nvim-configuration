-- show symbols
return {
    {
        "stevearc/aerial.nvim",
        event = "LspAttach",
        dependencies = { "nvim-treesitter/nvim-treesitter", optional = true },
        opts = function()
            local opts = {
                attach_mode = "global",
                backends = { "lsp", "treesitter", "markdown", "man" },
                disable_max_size = require("config.settings").large_buf.size,
                disable_max_lines = 1000,
                layout = { min_width = 28, default_direction = "prefer_right" },
                ignore = { filetypes = { "NvimTree", "terminal", "nofile" } },
                show_guides = true,
                filter_kind = false,
                guides = {
                    mid_item = "├ ",
                    last_item = "└ ",
                    nested_top = "│ ",
                    whitespace = "  ",
                },
                keymaps = {
                    ["[y"] = "actions.prev",
                    ["]y"] = "actions.next",
                    ["[Y"] = "actions.prev_up",
                    ["]Y"] = "actions.next_up",
                    ["{"] = false,
                    ["}"] = false,
                    ["[["] = false,
                    ["]]"] = false,
                },
            }

            return opts
        end,
    },
    {
        "catppuccin",
        optional = true,
        ---@type CatppuccinOptions
        opts = {
            integrations = { aerial = true },
        },
    },
}
