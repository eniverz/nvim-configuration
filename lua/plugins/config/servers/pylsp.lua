return {
    before_init = function(_, c)
        local path
        local conda_prefix = vim.env.CONDA_PREFIX
        local venv_prefix = vim.env.VIRTUAL_ENV
        if conda_prefix ~= nil and conda_prefix ~= "" then
            path = conda_prefix .. "/bin/python"
        else if venv_prefix ~= nil and venv_prefix ~= "" then
                path = venv_prefix .. "/bin/python"
            else
                path = vim.fn.exepath "python"
            end
        end
        c.settings.python.pythonPath = path
    end,
    cmd = { "pylsp" },
    filetypes = { "python" },
    settings = {
        pylsp = {
            plugins = {
                -- Lint
                ruff = {
                    enabled = true,
                    select = {
                        -- enable pycodestyle
                        "E",
                        -- enable pyflakes
                        "F",
                    },
                    ignore = {
                        -- ignore E501 (line too long)
                        -- "E501",
                        -- ignore F401 (imported but unused)
                        -- "F401",
                    },
                    extendSelect = { "I" },
                    severities = {
                        -- Hint, Information, Warning, Error
                        F401 = "I",
                        E501 = "I",
                    },
                },
                flake8 = { enabled = false },
                pyflakes = { enabled = false },
                pycodestyle = { enabled = false },
                mccabe = { enabled = false },

                -- Code refactor
                rope = { enabled = true },
            },
        },
    },
}
