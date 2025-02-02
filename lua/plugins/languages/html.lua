return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "html" })
            end
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "html-lsp", "emmet-ls" })
            end
        end,
    },
    {
        "neovim/nvim-lspconfig",
        optional = true,
        opts = {
            server = {
                html = { init_options = { provideFormatter = false }, filetype = { "html" } },
                emmet_ls = {
                    capabilities = { textDocument = { completion = { completionItem = { snippetSupport = true } } } },
                    init_options = {
                        html = {
                            options = {
                                -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                                ["bem.enabled"] = true,
                            },
                        },
                    },
                },
            },
        },
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = { formatters_by_ft = { html = { "prettier" } } },
    },
}
