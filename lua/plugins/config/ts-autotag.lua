--- Execute autocommand across all valid buffers
---@param event string|string[] the event or events to execute
---@param opts vim.api.keyset.exec_autocmds Dictionary of autocommnd options
local function exec_buffer_autocmds(event, opts)
    opts = require("utils.core").extend_tbl(opts, { modeline = false })
    for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
        for _, bufnr in ipairs(vim.t[tabpage].bufs or {}) do
            if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].filetype then
                opts.buffer = bufnr
                pcall(vim.api.nvim_exec_autocmds, event, opts)
            end
        end
    end
end


return function(_, opts)
    require("nvim-ts-autotag").setup(opts)
    exec_buffer_autocmds("FileType", { group = "nvim_ts_xmltag" })
end
