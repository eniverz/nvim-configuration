-- completion
return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                build = "make install_jsregexp",
                dependencies = { "rafamadriz/friendly-snippets" },
                config = require("plugins.config.luasnip"),
            },
            { "lukas-reineke/cmp-under-comparator" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },
            { "andersevenrud/cmp-tmux" },
            { "hrsh7th/cmp-path" },
            { "f3fora/cmp-spell" },
            { "hrsh7th/cmp-buffer" },
            { "kdheepak/cmp-latex-symbols" },
            { "ray-x/cmp-treesitter" },
        },
        config = require("plugins.config.cmp"),
    },
    {
        "catppuccin",
        optional = true,
        ---@type CatppuccinOptions
        opts = {
            integrations = { cmp = true },
        },
    },
}
