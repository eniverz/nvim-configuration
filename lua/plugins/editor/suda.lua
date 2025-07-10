-- write file by sudo
return {
    "lambdalisue/suda.vim",
    lazy = true,
    cmd = { "SudaRead", "SudaWrite" },
    keys = {
        { "<A-s>", ":<C-u>SudaWrite<CR>", desc = "edit: Save file using sudo" },
    },
    config = function(_, opts)
        require("suda").setup(opts)
        vim.g["suda#prompt"] = "Enter administrator password: "
    end,
}
