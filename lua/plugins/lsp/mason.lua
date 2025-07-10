return {
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        event = "VeryLazy",
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
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        cmd = {
            "Mason",
            "MasonInstall",
            "MasonUninstall",
            "MasonUninstallAll",
            "MasonLog",
        },
        opts = {
            ui = {
                border = "rounded",
                icons = {
                    package_installed = require("config.icons").get("ui").Check,
                    package_uninstalled = require("config.icons").get("misc").Ghost,
                    package_pending = require("config.icons").get("ui").Modified_alt,
                },
                keymaps = {
                    toggle_server_expand = "<CR>",
                    install_server = "i",
                    update_server = "u",
                    check_server_version = "c",
                    update_all_servers = "U",
                    check_outdated_servers = "C",
                    uninstall_server = "x",
                    cancel_installation = "<C-c>",
                },
            },
        },
        build = ":MasonUpdate",
        keys = {
            { "<leader>pm", ":Mason<CR>", desc = "Mason: Open Installer" },
            { "<leader>pL", ":MasonLog<CR>", desc = "Mason: Open Logger" },
        },
        config = function(_, opts)
            require("mason").setup(opts)
        end,
    },
    -- {
    --     "neovim/nvim-lspconfig",
    --     event = { "BufReadPre", "BufNewFile" },
    --     dependencies = {
    --         "williamboman/mason.nvim",
    --         "WhoIsSethDaniel/mason-tool-installer.nvim",
    --         "antosha417/nvim-lsp-file-operations",
    --         "saghen/blink.cmp",
    --     },
    --     config = function(_, opts)
    --         local native_diagnostics = require("config.settings").lsp.native_diagnostics
    --         local diagnostics_level = require("config.settings").lsp.diagnostics_level
    --         vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    --             signs = true,
    --             underline = true,
    --             virtual_text = native_diagnostics and {
    --                 min = diagnostics_level,
    --             } or false,
    --             -- set update_in_insert to false bacause it was enabled by lspsaga
    --             update_in_insert = false,
    --         })
    --         local nvim_lsp = require("lspconfig")
    --         require("lspconfig.ui.windows").default_options.border = "rounded"
    --         local on_attach = require("keymap.completion").on_attach
    --
    --         for server, config in pairs(opts.server) do
    --             config.on_attach = on_attach
    --             config.capabilities = require("blink.cmp").get_lsp_capabilities(
    --                 vim.tbl_extend(
    --                     "keep",
    --                     config.capabilities or {},
    --                     require("lsp-file-operations").default_capabilities(),
    --                     vim.lsp.protocol.make_client_capabilities()
    --                 )
    --             )
    --             nvim_lsp[server].setup(config)
    --         end
    --     end,
    -- },
}
