---@param path string
---@param root_path string
local function relpath(path, root_path)
    return path:gsub("^" .. root_path, "")
end

---@type overseer.TemplateFileDefinition
return {
    name = "python",
    priority = 60,
    params = function()
        local default_cmd = os.getenv("CONDA_PREFIX") .. "/bin/python"
        if not vim.fn.executable(default_cmd) then
            default_cmd = vim.fn.getenv("VIRTUAL_ENV") .. "/bin/python"
        end
        if not vim.fn.executable(default_cmd) then
            default_cmd = vim.fn.exepath("python")
        end

        return {
            cmd = { type = "string", default = default_cmd, order = 1 },
            target = { type = "string", default = relpath(vim.fn.expand("%:p"), vim.fn.getcwd(0, 0) .. "/"), order = 2 },
            args = { type = "list", delimiter = " ", optional = true, order = 3 },
            cwd = { optional = true, default = vim.fn.getcwd(0, 0), order = 4 },
        }
    end,
    condition = { filetype = { "python" } },
    builder = function(params)
        local cmd = params.cmd
        return {
            cmd = { cmd, params.target },
            args = params.args,
            cwd = params.cwd,
        }
    end,
}
