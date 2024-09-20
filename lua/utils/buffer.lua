local M = {}

local bufferline = require("bufferline")

--- Helper function to power a save confirmation prompt before `mini.bufremove`
---@param func fun(bufnr:integer,force:boolean?) The function to execute if confirmation is passed
---@param bufnr integer The buffer to close or the current buffer if not provided
---@param force? boolean Whether or not to foce close the buffers or confirm changes (default: false)
---@return boolean? # new value for whether to force save, `nil` to skip saving
local function mini_confirm(func, bufnr, force)
    if not force and vim.bo[bufnr].modified then
        local bufname = vim.fn.expand("%")
        local empty = bufname == ""
        if empty then
            bufname = "Untitled"
        end
        local confirm = vim.fn.confirm(('Save changes to "%s"?'):format(bufname), "&Yes\n&No\n&Cancel", 1, "Question")
        if confirm == 1 then
            if empty then
                return
            end
            vim.cmd.write()
        elseif confirm == 2 then
            force = true
        else
            return
        end
    end
    func(bufnr, force)
end

--- Close a given buffer
---@param bufnr? integer The buffer to close or the current buffer if not provided
---@param force? boolean Whether or not to foce close the buffers or confirm changes (default: false)
function M.close(bufnr, force)
    if not bufnr or bufnr == 0 then
        bufnr = vim.api.nvim_get_current_buf()
    end
    mini_confirm(require("mini.bufremove").delete, bufnr, force)
end

--- Close all buffers
---@param force? boolean Whether or not to foce close the buffers or confirm changes (default: false)
function M.close_all(force)
    for _, e in ipairs(bufferline.get_elements().elements) do
        M.close(e.id, force)
    end
end

return M
