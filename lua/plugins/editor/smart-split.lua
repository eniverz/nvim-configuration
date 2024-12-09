-- split window
return {
    "mrjones2014/smart-splits.nvim",
    event = "VeryLazy", -- load on very lazy for mux detection
    opts = { ignored_filetypes = { "nofile", "quickfix", "qf", "prompt", "neo-tree", "NvimTree" }, ignored_buftypes = { "nofile" } },
}
