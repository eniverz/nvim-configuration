---@type overseer.TemplateFileDefinition
return {
    priority = 60,
    params = {
        cmd = { type = "string", default = vim.fn.getenv("CONDA_PREFIX") .. "/bin/python" },
        args = { type = "list", delimiter = " " },
        cwd = { optional = true, default = vim.fn.getcwd() },
    },
    condition = { filetype = { "python" } },
    builder = function(params)
        local cmd = params.cmd
        if not vim.fn.executable(cmd) then
            cmd = vim.fn.getenv("VIRTUAL_ENV") .. "/bin/python"
        end
        if not vim.fn.executable(cmd) then
            cmd = vim.fn.exepath("python")
        end
        if not vim.fn.executable(cmd) then
            return nil
        end
        return {
            cmd = { cmd },
            args = params.args,
            cwd = params.cwd,
        }
    end,
}
