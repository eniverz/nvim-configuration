local M = {}

--- Insert one or more values into a list like table and maintain that you do not insert non-unique values (THIS MODIFIES `dst`)
---@param dst any[]|nil The list like table that you want to insert into
---@param src any[] Values to be inserted
---@return any[] # The modified list like table
function M.list_insert_unique(dst, src)
    if not dst then
        dst = {}
    end
    -- TODO: remove check after dropping support for Neovim v0.9
    assert(vim.islist(dst), "Provided table is not a list like table")
    local added = {}
    for _, val in ipairs(dst) do
        added[val] = true
    end
    for _, val in ipairs(src) do
        if not added[val] then
            table.insert(dst, val)
            added[val] = true
        end
    end
    return dst
end

--- Convert a table to a string
---@param table table
---@param str string
---@return string
function M.toStr(table, str)
    for k, v in pairs(table) do
        if type(v) == "table" then
            str = M.toStr(v, str .. k .. ".")
        elseif type(v) == "function" then
            str = str .. k .. " = function\n"
        elseif type(v) == "boolean" then
            str = str .. k .. " = " .. (v and "true" or "false") .. "\n"
        else
            str = str .. k .. " = " .. v .. "\n"
        end
    end
    return str
end

return M
