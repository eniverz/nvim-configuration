return {
    {
        -- formatter
        "b0o/schemastore.nvim",
        lazy = true,
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
        opts = function(_, opts)
            opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "json-lsp" })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        optional = true,
        opts = function(_, opts)
            opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "jsonls" })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function (_, opts)
            require("lspconfig").jsonls.setup({
                flags = { debounce_text_changes = 500 },
                capabilities = opts.capabilities,
                on_attach = opts.on_attach,
                on_new_config = function(config)
                    if not config.settings.json.schemas then config.settings.json.schemas = {} end
                    vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
                end,
                settings = { json = { validate = { enable = true } } },
            })
        end
    }
}
