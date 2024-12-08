return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "saghen/blink.cmp",
        optional = true,
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            local enabled_providers = opts.sources.completion.enabled_providers or {}
            local providers = opts.sources.providers or {}
            opts.sources.completion.enabled_providers = require("utils.core").list_insert_unique(enabled_providers, { "lazydev" })
            opts.sources.providers = vim.tbl_extend("force", providers, {
                -- dont show LuaLS require statements when lazydev has items
                lsp = { fallback_for = { "lazydev" } },
                lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
            })
        end,
    },
}
