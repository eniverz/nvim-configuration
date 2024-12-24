-- better command line
return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        {
            "nvim-treesitter/nvim-treesitter",
            optional = true,
            opts = function(_, opts)
                if opts.ensure_installed ~= "all" then
                    opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "regex" })
                end
            end,
        },
    },
    opts = function(_, opts)
        return vim.tbl_extend("force", opts, {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
                signature = { enabled = false },
            },
            -- presets = {
            --   bottom_search = false, -- use a classic bottom cmdline for search
            --   command_palette = true, -- position the cmdline and popupmenu together
            --   long_message_to_split = true, -- long messages will be sent to a split
            --   inc_rename = utils.is_available "inc-rename.nvim", -- enables an input dialog for inc-rename.nvim
            --   lsp_doc_border = false, -- add a border to hover docs and signature help
            -- },
            presets = false,
        })
    end,
}
