return {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
        ".git",
    },
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
            },
        },
    },
    before_init = function(_, config)
        local path = vim.fn.exepath("python")
        local sep = require("config.global").is_windows and "\\" or "/"
        local conda_prefix = vim.env.CONDA_PREFIX
        local venv_prefix = vim.env.VIRTUAL_ENV
        if conda_prefix ~= nil and conda_prefix ~= "" then
            path = conda_prefix .. sep .. "bin" .. sep .. "python"
        elseif venv_prefix ~= nil and venv_prefix ~= "" then
            path = venv_prefix .. sep .. "bin" .. sep .. "python"
        end

        config.settings.python.pythonPath = path
    end,
    on_attach = function(client, bufnr)
        vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightOrganizeImports", function()
            client:exec_cmd({
                command = "pyright.organizeimports",
                arguments = { vim.uri_from_bufnr(bufnr) },
            })
        end, {
            desc = "Organize Imports",
        })
    end,
}
