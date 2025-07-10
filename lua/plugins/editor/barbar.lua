-- tab bar
return {
    {
        "romgrk/barbar.nvim",
        lazy = true,
        event = { "BufReadPost", "BufAdd", "BufNewFile" },
        dependencies = {
            "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
            "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
        },
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        opts = function()
            local icon_config = require("config.icons")
            local icons = { diagnostics = icon_config.get("diagnostics"), git = icon_config.get("git"), ui = icon_config.get("ui") }
            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error_alt,
                        [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning_alt,
                        [vim.diagnostic.severity.INFO] = icons.diagnostics.Information_alt,
                        [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint_alt,
                    },
                    numhl = {
                        [vim.diagnostic.severity.ERROR] = "DiagnosticsSignError",
                        [vim.diagnostic.severity.WARN] = "DiagnosticsSignWarn",
                        [vim.diagnostic.severity.INFO] = "DiagnosticsSignInfo",
                        [vim.diagnostic.severity.HINT] = "DiagnosticsSignHint",
                    },
                },
            })
            return {
                icons = {
                    buffer_index = true,
                    pinned = { button = icons.ui.Pin, filename = true },
                    diagnostics = {
                        [vim.diagnostic.severity.ERROR] = { enabled = true, icon = icons.diagnostics.Error_alt },
                        [vim.diagnostic.severity.WARN] = { enabled = true, icon = icons.diagnostics.Warning_alt },
                        [vim.diagnostic.severity.INFO] = { enabled = true, icon = icons.diagnostics.Information_alt },
                        [vim.diagnostic.severity.HINT] = { enabled = true, icon = icons.diagnostics.Hint_alt },
                    },
                    gitsigns = {
                        added = { enabled = true, icon = icons.git.Add },
                        changed = { enabled = true, icon = icons.git.Modified },
                        deleted = { enabled = true, icon = icons.git.Remove },
                    },
                },
            }
        end,
        keys = {
            {"<A-Left>", "<Cmd>BufferPrevious<CR>", desc = "Buffer: previous"},
            {"<A-Right>", "<Cmd>BufferNext<CR>", desc = "Buffer: next"},
            {"<A-j>", "<Cmd>BufferPrevious<CR>", desc = "Buffer: previous"},
            {"<A-k>", "<Cmd>BufferNext<CR>", desc = "Buffer: next"},
            {"<A-S-j>", "<Cmd>BufferMovePrevious<CR>", desc = "Buffer: move buffer previous"},
            {"<A-S-k>", "<Cmd>BufferMoveNext<CR>", desc = "Buffer: move buffer next"},
            {"<leader>bG", "<Cmd>BufferLast<CR>", desc = "Buffer: goto last buffer"},
            {"<leader>bp", "<Cmd>BufferPick<CR>", desc = "Buffer: pick one buffer"},
            {"<leader>bP", "<Cmd>BufferPin<CR>", desc = "Buffer: pin/unpin current buffer"},
            {"<leader>c", "<Cmd>BufferClose<CR>", desc = "Buffer: close current buffer"},
            {"<leader>bc", "<Cmd>BufferCloseAllButCurrentOrPinned<CR>", desc = "Buffer: close buffers except current"},
            {"<leader>bl", "<Cmd>BufferCloseBuffersLeft<CR>", desc = "Buffer: close left buffers"},
            {"<leader>br", "<Cmd>BufferCloseBuffersRight<CR>", desc = "Buffer: close right buffers"},
            {"<leader>bR", "<Cmd>BufferRestore<CR>", desc = "Buffer: restore closed buffer"},

            {"<leader>bsi", "<Cmd>BufferOrderByBufferNumber<CR>", desc = "Buffer: sort by buffer id"},
            {"<leader>bsn", "<Cmd>BufferOrderByName<CR>", desc = "Buffer: sort by buffer name"},
            {"<leader>bsd", "<Cmd>BufferOrderByDirectory<CR>", desc = "Buffer: sort by buffer path"},
            {"<leader>bsl", "<Cmd>BufferOrderByLanguage<CR>", desc = "Buffer: sort by code language"},
            {"<leader>bsw", "<Cmd>BufferOrderByWindowNumber<CR>", desc = "Buffer: sort by window number"},
        },
    },
    {
        "stevearc/resession.nvim",
        optional = true,
        opts = {
            extensions = {
                barbar = {},
            },
        },
    },
}
