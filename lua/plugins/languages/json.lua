return {
    {
        "b0o/schemastore.nvim",
        lazy = true,
        ft = { "json" },
    },
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
        opts = function(_, opts)
            opts.server = opts.server or {}
            opts.settings = opts.settings or {}
            opts.server.jsonls = {}
            opts.settings.json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enabled = true },
            }
        end,
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
