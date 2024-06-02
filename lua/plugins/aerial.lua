local settings = require("config.settings")

return {
    "stevearc/aerial.nvim",
    event = "LspAttach",
    opts = function()
        local opts = {
            attach_mode = "global",
            backends = { "lsp", "treesitter", "markdown", "man" },
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

        opts.disable_max_lines, opts.disable_max_size = settings.large_buf.lines, settings.large_buf.size

        return opts
    end,
}
