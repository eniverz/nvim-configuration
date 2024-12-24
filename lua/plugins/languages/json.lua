return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "json", "jsonc" })
            end
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = { ensure_installed = { "json-lsp", "fixjson" } },
    },
    {
        "neovim/nvim-lspconfig",
        optional = true,
        dependencies = {
            "b0o/schemastore.nvim",
            lazy = true,
            ft = { "json" },
        },
        opts = {
            server = {
                jsonls = { capabilities = { textDocument = { completion = { completionItem = { snippetSupport = true } } } } },
                settings = {
                    jsonls = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enabled = true },
                    },
                },
            },
        },
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                json = { { "fixjson" } },
                jsonc = { { "fixjson" } },
            },
        },
    },
}
