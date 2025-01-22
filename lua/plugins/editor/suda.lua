-- write file by sudo
return {
    "lambdalisue/suda.vim",
    lazy = true,
    cmd = { "SudaRead", "SudaWrite" },
    config = function(_, opts)
        require("suda").setup(opts)
        vim.g["suda#prompt"] = "Enter administrator password: "
    end,
}
