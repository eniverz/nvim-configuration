return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        {
            "antosha417/nvim-lsp-file-operations",
            config = true,
        }
    },
    config = function (_, opts)
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        opts.capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
        opts.on_attach = require("keymap.completion")

        vim.api.nvim_command([[LspStart]])
    end
}
