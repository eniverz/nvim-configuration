return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts)
        local scheme = require("config.scheme")
        require("tokyonight").setup(vim.tbl_extend("force", opts, {
            transparent = scheme.transparent_background,
        }))
        if scheme.colorscheme:find("tokyonight") then
            vim.api.nvim_command("colorscheme " .. scheme.colorscheme)
        end
    end,
}
