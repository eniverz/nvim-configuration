-- the best fuzzy finder for neovim
return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim", lazy = true },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                lazy = true,
                enabled = vim.fn.executable("make") == 1,
                build = "make",
            },
            { "nvim-tree/nvim-web-devicons" },
            { "debugloop/telescope-undo.nvim" },
            {
                "ahmedkhalf/project.nvim",
                event = { "CursorHold", "CursorHoldI" },
                opts = {
                    manual_mode = false,
                    detection_methods = { "lsp", "pattern" },
                    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "CMakeLists.txt", "package.json", "requirements.txt", "pyproject.toml" },
                    ignore_lsp = { "null-ls", "copilot", "conform" },
                    exclude_dirs = {},
                    show_hidden = false,
                    silent_chdir = true,
                    scope_chdir = "global",
                    datapath = vim.fn.stdpath("data"),
                },
                config = function(_, opts)
                    require("project_nvim").setup(opts)
                end,
            },
            { "nvim-telescope/telescope-frecency.nvim" },
            { "nvim-telescope/telescope-live-grep-args.nvim" },
        },
        cmd = "Telescope",
        opts = function()
            local lga_actions = require("telescope-live-grep-args.actions")
            local icons = { ui = require("config.icons").get("ui", true) }

            return {
                defaults = {
                    vimgrep_arguments = {
                        "rg",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                    },
                    initial_mode = "insert",
                    prompt_prefix = " " .. icons.ui.Telescope .. " ",
                    selection_caret = icons.ui.ChevronRight,
                    scroll_strategy = "limit",
                    results_title = false,
                    layout_strategy = "horizontal",
                    path_display = { "absolute" },
                    selection_strategy = "reset",
                    sorting_strategy = "ascending",
                    color_devicons = true,
                    file_ignore_patterns = require("config.settings").ignore_files,
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.55,
                            results_width = 0.8,
                        },
                        vertical = {
                            mirror = false,
                        },
                        width = 0.85,
                        height = 0.92,
                        preview_cutoff = 120,
                    },
                    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                    file_sorter = require("telescope.sorters").get_fuzzy_file,
                    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
                },
                extensions = {
                    aerial = {
                        show_lines = false,
                        show_nesting = {
                            ["_"] = false, -- This key will be the default
                            lua = true, -- You can set the option for specific filetypes
                        },
                    },
                    fzf = {
                        fuzzy = false,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                    frecency = {
                        use_sqlite = false,
                        show_scores = true,
                        show_unindexed = true,
                        ignore_patterns = { "*/[.]git/*", "*/tmp/*" },
                    },
                    live_grep_args = {
                        auto_quoting = true, -- enable/disable auto-quoting
                        -- define mappings, e.g.
                        mappings = { -- extend mappings
                            i = {
                                ["<C-k>"] = lga_actions.quote_prompt(),
                                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                            },
                        },
                    },
                    undo = {
                        side_by_side = true,
                        mappings = { -- this whole table is the default
                            i = {
                                -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
                                -- you want to use the following actions. This means installing as a dependency of
                                -- telescope in it's `requirements` and loading this extension from there instead of
                                -- having the separate plugin definition as outlined above. See issue #6.
                                ["<cr>"] = require("telescope-undo.actions").restore,
                            },
                            n = {
                                ["<cr>"] = require("telescope-undo.actions").restore,
                            },
                        },
                    },
                },
            }
        end,
        config = function(_, opts)
            local telescope = require("telescope")
            telescope.setup(opts)
            telescope.load_extension("frecency")
            telescope.load_extension("fzf")
            telescope.load_extension("live_grep_args")
            telescope.load_extension("projects")
            telescope.load_extension("undo")
            telescope.load_extension("remote-sshfs")
        end,
    },
    {
        "catppuccin/nvim",
        optional = true,
        ---@type CatppuccinOptions
        opts = { integrations = { telescope = { enabled = vim.g.colors_name:find("catppuccin"), style = "nvchad" } } },
    },
}
