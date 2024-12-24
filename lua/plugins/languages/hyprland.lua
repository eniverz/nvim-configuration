-- for hyprland config files
return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "hyprlang" })
            end
            vim.filetype.add({
                pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
            })
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = { ensure_installed = { "hyprls" } },
    },
    {
        "neovim/nvim-lspconfig",
        optional = true,
        opts = { server = { hyprls = {} } },
    },
}
