return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "cmake" })
            end
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "neocmakelsp" })
            end
        end,
    },
    {
        "neovim/nvim-lspconfig",
        optional = true,
        opts = {
            server = {
                neocmake = {
                    capabilities = { textDocument = { completion = { completionItem = { snippetSupport = true } } } },
                    init_options = { buildDirectory = "cmake-build-debug" },
                },
            },
        },
    },
}
