-- better inline diagnostics
return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach", -- Or `LspAttach`
    config = function(_, opts)
        if require("config.settings").lsp.native_diagnostics then
            return
        end
        require("tiny-inline-diagnostic").setup(opts)
        vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
    end,
}
