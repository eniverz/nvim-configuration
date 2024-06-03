return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            {
                "antosha417/nvim-lsp-file-operations",
                config = true,
            },
            {
                "folke/neodev.nvim",
                lazy = true,
                config = true,
            },
        },
        config = function (_, opts)
            require("lspconfig.ui.windows").default_options.border = "rounded"
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            opts.capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
            opts.on_attach = require("keymap.completion").lsp

            vim.api.nvim_command([[LspStart]])
        end
    },
    {
        "Jint-lzxy/lsp_signature.nvim",
        opts =  {
            bind = true,
            -- TODO: Remove the following line when nvim-cmp#1613 gets resolved
            check_completion_visible = false,
            floating_window = true,
            floating_window_above_cur_line = true,
            hi_parameter = "Search",
            hint_enable = true,
            transparency = nil, -- disabled by default, allow floating win transparent value 1~100
            wrap = true,
            zindex = 45,  -- avoid overlap with nvim.cmp
            handler_opts = { border = "single" },
        },
        config = function() require("lsp_signature") end
    },
    {
        "onsails/lspkind.nvim",
        lazy = true,
        enabled = vim.g.icons_enabled ~= false,
        opts = {
            mode = "symbol",
            symbol_map = {
                Array = "󰅪",
                Boolean = "⊨",
                Class = "󰌗",
                Constructor = "",
                Key = "󰌆",
                Namespace = "󰅪",
                Null = "NULL",
                Number = "#",
                Object = "󰀚",
                Package = "󰏗",
                Property = "",
                Reference = "",
                Snippet = "",
                String = "󰀬",
                TypeParameter = "󰊄",
                Unit = "",
            },
            menu = {},
        },
        config= function()end
    },
    {
        "nvimdev/lspsaga.nvim",
        lazy = true,
        event = "LspAttach",
        cmd = "Lspsaga",
        dependencies = {
            "neovim/nvim-lspconfig",
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
        },
        config = require("plugins.config.lspsaga"),
    }
}
