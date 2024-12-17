-- auto close tags
return {
    "windwp/nvim-ts-autotag",
    lazy = vim.fn.argc(-1) == 0,
    event = { "BufReadPre", "FileType" },
    opts = {
        filetypes = {
            "html",
            "javascript",
            "javascriptreact",
            "typescriptreact",
            "vue",
            "xml",
        },
    },
    config = function(_, opts)
        require("nvim-ts-autotag").setup(opts)
        for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
            for _, bufnr in ipairs(vim.t[tabpage].bufs or {}) do
                if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].filetype then
                    pcall(vim.api.nvim_exec_autocmds, "FileType", { bufnr = bufnr, group = "nvim_ts_xmltag", modeline = false })
                end
            end
        end
    end,
}
