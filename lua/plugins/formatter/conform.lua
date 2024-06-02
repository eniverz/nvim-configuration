return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function ()
        require("conform").setup({
            format_on_saved = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 500
            }
        })
    end
}
