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
    { "antosha417/nvim-lsp-file-operations", event = "LspAttach" },
}
