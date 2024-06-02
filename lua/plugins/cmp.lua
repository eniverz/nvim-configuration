return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        {
            "L3MON4D3/LuaSnip",
            dependencies = { "rafamadriz/friendly-snippets" },
            opts = {
                history = true,
                update_events = "TextChanged,TextChangedI",
                delete_check_events = "TextChanged,InsertLeave",
            },
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
        { "ray-x/cmp-treesitter",              commit = "c8e3a74" },
    },
    event = "InsertEnter",
    config = require("plugins.config.cmp"),
}
