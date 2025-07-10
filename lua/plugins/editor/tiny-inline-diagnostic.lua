-- better inline diagnostics
return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach", -- Or `LspAttach`
    opts = {
        options = {
            multilines = {
                enabled = true,
                always_show = true,
            },
        },
    },
    keys = {
        {
            "<leader>uD",
            function()
                local td = require("tiny-inline-diagnostic")
                local toggle = Snacks.toggle.diagnostics()
                if toggle:get() then
                    td.disable()
                else
                    td.enable()
                end
                toggle:toggle()
            end,
        },
    },
    config = function(_, opts)
        if require("config.settings").settings.lsp.native_diagnostics then
            return
        end
        require("tiny-inline-diagnostic").setup(opts)
        vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
    end,
}
