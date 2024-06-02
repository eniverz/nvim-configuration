-- write file by sudo
return {
    "lambdalisue/suda.vim",
    lazy = true,
    cmd = { "SudaRead", "SudaWrite" },
    config = function()
        vim.g["suda#prompt"] = "Enter administrator password: "
        require("suda").setup()
    end,
}
