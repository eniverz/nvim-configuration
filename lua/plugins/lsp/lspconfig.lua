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
            {
                "williamboman/mason.nvim",
                cmd = {
                    "Mason",
                    "MasonInstall",
                    "MasonUninstall",
                    "MasonUninstallAll",
                    "MasonLog",
                },
                opts = {
                    ui = {
                        icons = {
                            package_installed = "✓",
                            package_uninstalled = "✗",
                            package_pending = "⟳",
                        },
                    },
                    keymaps = {
                        toggle_server_expand = "<CR>",
                        install_server = "i",
                        update_server = "u",
                        check_server_version = "c",
                        update_all_servers = "U",
                        check_outdated_servers = "C",
                        uninstall_server = "X",
                        cancel_installation = "<C-c>",
                    },
                },
                build = ":MasonUpdate",
                config = require("plugins.config.mason"),
            },
            {
                "williamboman/mason-lspconfig.nvim",
                dependencies = { "williamboman/mason.nvim" },
                lazy = true,
                config = require("plugins.config.mason-lspconfig"),
            },
            {
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                -- lazy = true,
                dependencies = { "williamboman/mason.nvim" },
                opts = {
                    integrations = {
                        ["mason-lspconfig"] = false,
                        ["mason-null-ls"] = false,
                        ["mason-nvim-dap"] = false,
                    },
                },
                config = function(_, opts)
                    require("mason-tool-installer").setup(opts)
                end,
            },
        },
        config = function(_, opts)
            require("lspconfig.ui.windows").default_options.border = "rounded"
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            opts.capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
            opts.on_attach = require("keymap.completion").lsp

            vim.api.nvim_command([[LspStart]])
        end,
    },
    {
        "Jint-lzxy/lsp_signature.nvim",
        opts = {
            bind = true,
            -- TODO: Remove the following line when nvim-cmp#1613 gets resolved
            check_completion_visible = false,
            floating_window = true,
            floating_window_above_cur_line = true,
            hi_parameter = "Search",
            hint_enable = true,
            transparency = nil, -- disabled by default, allow floating win transparent value 1~100
            wrap = true,
            zindex = 45, -- avoid overlap with nvim.cmp
            handler_opts = { border = "single" },
        },
        config = function()
            require("lsp_signature")
        end,
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
        config = function() end,
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
    },
    {
        "catppuccin",
        optional = true,
        ---@type CatppuccinOptions
        opts = {
            integrations = { lsp_saga = true, lsp_trouble = true, mason = true },
        },
    },
}
