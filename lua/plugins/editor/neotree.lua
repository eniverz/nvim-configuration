-- file manager
return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    opts = function()
        local icons = {
            diagnostics = require("config.icons").get("diagnostics"),
            dap = require("config.icons").get("dap"),
            ui = require("config.icons").get("ui"),
            git = require("config.icons").get("git"),
        }
        vim.fn.sign_define("DiagnosticsSignError", { text = icons.diagnostics.Error, texthl = "DiagnosticsSignError" })
        vim.fn.sign_define("DiagnosticsSignWarning", { text = icons.diagnostics.Warning, texthl = "DiagnosticsSignWarning" })
        vim.fn.sign_define("DiagnosticsSignInformation", { text = icons.diagnostics.Information, texthl = "DiagnosticsSignInformation" })
        vim.fn.sign_define("DiagnosticsSignHint", { text = icons.diagnostics.Hint, texthl = "DiagnosticsSignHint" })

        return {
            enable_git_status = true,
            enable_diagnostics = true,
            sort_function = function(a, b)
                if a.type == b.type then
                    return a.path < b.path
                else
                    return a.type < b.type
                end
            end, -- this sorts files and directories descendantly
            default_component_configs = {
                icons = {
                    folder_close = icons.ui.Folder,
                    folder_open = icons.ui.FolderOpen,
                    folder_empty = icons.ui.EmptyFolder,
                },
                git_status = {
                    symbols = {
                        -- Change type
                        added = icons.git.Add,
                        modified = icons.git.Mod_alt,
                        deleted = icons.git.Remove,
                        renamed = icons.git.Rename,
                        -- Status type
                        conflict = icons.git.Conflict,
                        unstaged = icons.git.Mod_alt,
                        staged = icons.git.Add,
                        unmerged = icons.git.Unmerged,
                        untracked = icons.git.Untracked,
                        ignored = icons.git.Ignore,
                    },
                },
                window = {
                    position = "float",
                    width = math.floor(vim.opt.columns:get() <= 160 and 64 or vim.opt.columns:get() * 0.4),
                },
                filesystem = {
                    filtered_items = {
                        visible = true,
                        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                            ".DS_Store",
                            "thumbs.db",
                        },
                    },
                },
            },
        }
    end,
    config = function(_, opts)
        local Highlight = require("utils.highlight")
        local palette = require("catppuccin.palettes.mocha")

        local neotree_highlights = Highlight.HighlightGroups({
            NeoTreeGitAdded = { guifg = palette.green },
            NeoTreeGitStaged = { guifg = palette.teal},

            NeoTreeGitConflict = { guifg = palette.maroon},

            NeoTreeGitDeleted = { guifg = palette.red },
            NeoTreeModified = { guifg = palette.peach },
            NeoTreeGitUnstaged = { guifg = palette.sky },
            NeoTreeGitUntracked = { guifg = palette.sky },

            NeoTreeGitModified = { guifg = palette.yellow },
            NeoTreeGitModified_35 = { guifg = palette.yellow },
            NeoTreeGitModified_60 = { guifg = palette.yellow },
            NeoTreeGitModified_68 = { guifg = palette.yellow },
        })
        Highlight:new():add(neotree_highlights):register_highlights()

        require("neo-tree").setup(opts)
    end,
}
