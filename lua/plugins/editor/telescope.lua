-- the best fuzzy finder for neovim
return {
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
    },
    cmd = "Telescope",
    opts = function(_, opts)
        local icons = { ui = require("config.icons").get("ui", true) }

        local new_opts = {
            defaults = {
                prompt_prefix = " " .. icons.ui.Telescope .. " ",
                selection_caret = icons.ui.ChevronRight,
                file_ignore_patterns = require("config.settings").ignore_files,
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
                undo = {
                    side_by_side = true,
                    mappings = { -- this whole table is the default
                        i = { ["<cr>"] = require("telescope-undo.actions").restore },
                        n = { ["<cr>"] = require("telescope-undo.actions").restore },
                    },
                },
            },
        }
        return vim.tbl_extend("force", new_opts, opts)
    end,
    config = function(_, opts)
        local telescope = require("telescope")
        telescope.setup(opts)
        telescope.load_extension("fzf")
        telescope.load_extension("undo")
    end,
}
