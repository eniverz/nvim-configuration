---@type overseer.TemplateFileDefinition
return {
    priority = 60,
    params = {
        args = { type = "list", delimiter = " " },
        cwd = { optional = true, default = vim.fn.getcwd() },
    },
    condition = { filetype = { "python" } },
    builder = function(params)
        return {
            cmd = { "python" },
            args = params.args,
            cwd = params.cwd,
        }
    end,
}
