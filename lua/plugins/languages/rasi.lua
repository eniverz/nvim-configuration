return {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
        if opts.ensure_installed ~= "all" then
            opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "rasi" })
        end
        vim.filetype.add({
            extension = {
                rasi = "rasi",
            },
        })
    end,
}
