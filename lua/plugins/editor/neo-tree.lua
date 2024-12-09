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
            ui = require("config.icons").get("ui"),
            git = require("config.icons").get("git"),
        }

        return {
            close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
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
            },
            window = {
                position = "float",
                mappings = {
                    ["a"] = {
                        "add",
                        -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
                        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                        config = {
                            show_path = "absolute", -- "none", "relative", "absolute"
                        },
                    },
                },
            },
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_hidden = false,
                    never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                        ".DS_Store",
                        "thumbs.db",
                    },
                },
            },
        }
    end,
    config = function(_, opts)
        require("neo-tree").setup(opts)
    end,
}
