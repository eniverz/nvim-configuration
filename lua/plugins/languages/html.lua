return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "html", "css" })
            end
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        optional = true,
        opts = function(_, opts)
            opts.ensure_installed =
            require("utils.core").list_insert_unique(opts.ensure_installed, { "html", "cssls", "emmet_ls", "tailwindcss" })
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = function(_, opts)
            opts.ensure_installed = require("utils.core").list_insert_unique(
                opts.ensure_installed,
                { "html-lsp", "css-lsp", "emmet-ls", "prettierd" }
            )
        end,
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                html = { { "prettierd", "prettier" } },
                css = { { "prettierd", "prettier" } },
                sass = { { "prettierd", "prettier" } },
                scss = { { "prettierd", "prettier" } },
                less = { { "prettierd", "prettier" } },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function (_, opts)
            require("lspconfig").html.setup({
                cmd = { "html-languageserver", "--stdio" },
                filetypes = { "html" },
                init_options = {
                    configurationSection = { "html", "css", "javascript" },
                    embeddedLanguages = { css = true, javascript = true },
                    provideFormatter = false,
                },
                settings = {},
                single_file_support = true,
                flags = { debounce_text_changes = 500 },

                capabilities = opts.capabilities,
                on_attach = opts.on_attach,
            })
            require("lspconfig").cssls.setup({
                init_options = { provideFormatter = false },
                capabilities = opts.capabilities,
                on_attach = opts.on_attach,
            })
        end
    }
}
