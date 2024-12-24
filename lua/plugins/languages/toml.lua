return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
            -- Ensure that opts.ensure_installed exists and is a table or string "all".
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "toml" })
            end
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = { ensure_installed = { "taplo" } },
    },
    {
        "neovim/nvim-lspconfig",
        optional = true,
        opts = { server = { taplo = {} } },
    },
}
