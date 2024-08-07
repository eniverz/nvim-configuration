-- file tree
return {
    {
        "nvim-tree/nvim-tree.lua",
        lazy = true,
        cmd = {
            "NvimTreeToggle",
            "NvimTreeOpen",
            "NvimTreeFindFile",
            "NvimTreeFindFileToggle",
            "NvimTreeRefresh",
        },
        config = function()
            local icons = {
                diagnostics = require("config.icons").get("diagnostics"),
                documents = require("config.icons").get("documents"),
                git = require("config.icons").get("git"),
                ui = require("config.icons").get("ui"),
            }

            local HEIGHT_RATIO = 0.8
            local WIDTH_RATIO = 0.4

            require("nvim-tree").setup({
                auto_reload_on_write = true,
                create_in_closed_folder = false,
                disable_netrw = false,
                hijack_cursor = true,
                hijack_netrw = true,
                hijack_unnamed_buffer_when_opening = true,
                open_on_tab = false,
                respect_buf_cwd = false,
                sort_by = "name",
                sync_root_with_cwd = true,
                view = {
                    number = true,
                    relativenumber = false,
                    preserve_window_proportions = true,
                    signcolumn = "yes",
                    float = {
                        enable = true,
                        quit_on_focus_loss = true,
                        open_win_config = function()
                            local screen_w = vim.opt.columns:get()
                            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                            local window_w = screen_w <= 160 and 64 or screen_w * WIDTH_RATIO
                            local window_h = screen_h * HEIGHT_RATIO
                            local window_w_int = math.floor(window_w)
                            local window_h_int = math.floor(window_h)
                            local center_x = (screen_w - window_w) / 2
                            local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
                            return {
                                title = " NvimTree ",
                                title_pos = "center",
                                border = "rounded", -- none, single, double, shadow
                                relative = "editor",
                                row = center_y,
                                col = center_x,
                                width = window_w_int,
                                height = window_h_int,
                            }
                        end,
                    },
                    width = function()
                        return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
                    end,
                },
                renderer = {
                    add_trailing = false,
                    group_empty = true,
                    highlight_git = true,
                    full_name = false,
                    highlight_opened_files = "none",
                    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "CMakeLists.txt" },
                    symlink_destination = true,
                    indent_markers = {
                        enable = true,
                        icons = {
                            corner = "└ ",
                            edge = "│ ",
                            item = "│ ",
                            none = "  ",
                        },
                    },
                    root_folder_label = ":.:s?.*?/..?",
                    icons = {
                        webdev_colors = true,
                        git_placement = "after",
                        show = {
                            file = true,
                            folder = true,
                            folder_arrow = true,
                            git = true,
                        },
                        padding = " ",
                        symlink_arrow = " 󰁔 ",
                        glyphs = {
                            default = icons.documents.Default, --
                            symlink = icons.documents.Symlink, --
                            bookmark = icons.ui.Bookmark,
                            git = {
                                unstaged = icons.git.Mod_alt,
                                staged = icons.git.Add, --󰄬
                                unmerged = icons.git.Unmerged,
                                renamed = icons.git.Rename, --󰁔
                                untracked = icons.git.Untracked, -- "󰞋"
                                deleted = icons.git.Remove, --
                                ignored = icons.git.Ignore, --◌
                            },
                            folder = {
                                arrow_open = icons.ui.ArrowOpen,
                                arrow_closed = icons.ui.ArrowClosed,
                                -- arrow_open = "",
                                -- arrow_closed = "",
                                default = icons.ui.Folder,
                                open = icons.ui.FolderOpen,
                                empty = icons.ui.EmptyFolder,
                                empty_open = icons.ui.EmptyFolderOpen,
                                symlink = icons.ui.SymlinkFolder,
                                symlink_open = icons.ui.FolderOpen,
                            },
                        },
                    },
                },
                hijack_directories = {
                    enable = true,
                    auto_open = true,
                },
                update_focused_file = {
                    enable = true,
                    update_root = true,
                    ignore_list = {},
                },
                filters = {
                    dotfiles = false,
                    custom = { ".DS_Store" },
                    exclude = {},
                },
                actions = {
                    use_system_clipboard = true,
                    change_dir = {
                        enable = true,
                        global = false,
                    },
                    open_file = {
                        quit_on_open = false,
                        resize_window = false,
                        window_picker = {
                            enable = true,
                            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                            exclude = {
                                filetype = { "notify", "qf", "diff", "fugitive", "fugitiveblame" },
                                buftype = { "terminal", "help" },
                            },
                        },
                    },
                    remove_file = {
                        close_window = true,
                    },
                },
                diagnostics = {
                    enable = false,
                    show_on_dirs = false,
                    debounce_delay = 50,
                    icons = {
                        hint = icons.diagnostics.Hint_alt,
                        info = icons.diagnostics.Information_alt,
                        warning = icons.diagnostics.Warning_alt,
                        error = icons.diagnostics.Error_alt,
                    },
                },
                filesystem_watchers = {
                    enable = true,
                    debounce_delay = 50,
                },
                git = {
                    enable = true,
                    ignore = false,
                    show_on_dirs = true,
                    timeout = 400,
                },
                trash = {
                    cmd = "gio trash",
                    require_confirm = true,
                },
                live_filter = {
                    prefix = "[FILTER]: ",
                    always_show_folders = true,
                },
                log = {
                    enable = false,
                    truncate = false,
                    types = {
                        all = false,
                        config = false,
                        copy_paste = false,
                        dev = false,
                        diagnostics = false,
                        git = false,
                        profile = false,
                        watcher = false,
                    },
                },
            })
            vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#5E81AC" })
        end,
    },
    {
        "catppuccin",
        optional = true,
        ---@type CatppuccinOptions
        opts = { integrations = { nvimtree = true } },
    },
}
