return {
    filetypes = { "python" },
    before_init = function(_, c)
        local path = vim.fn.exepath("python")
        local conda_prefix = vim.env.CONDA_PREFIX
        local venv_prefix = vim.env.VIRTUAL_ENV
        if conda_prefix ~= nil and conda_prefix ~= "" then
            path = conda_prefix .. "/bin/python"
        elseif venv_prefix ~= nil and venv_prefix ~= "" then
            path = venv_prefix .. "/bin/python"
        end

        c.settings.python.pythonPath = path
    end,
}
