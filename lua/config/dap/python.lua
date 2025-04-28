-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#python
-- https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
return function()
    local dap = require("dap")
    local debugpy = vim.fn.exepath("debugpy-adapter")

    local function is_empty(s)
        return s == nil or s == ""
    end

    dap.adapters.python = function(callback, config)
        if config.request == "attach" then
            ---@diagnostic disable-next-line: undefined-field
            local port = (config.connect or config).port
            ---@diagnostic disable-next-line: undefined-field
            local host = (config.connect or config).host or "127.0.0.1"
            callback({
                type = "server",
                port = assert(port, "`connect.port` is required for a python `attach` configuration"),
                host = host,
                options = { source_filetype = "python" },
            })
        else
            callback({
                type = "executable",
                command = debugpy,
                options = { source_filetype = "python" },
            })
        end
    end

    dap.configurations.python = {
        {
            -- The first three options are required by nvim-dap
            type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
            request = "launch",
            name = "Launch Python Debugger",
            -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
            console = "integratedTerminal",
            program = function()
                return vim.fn.input("Path to debuggee(default is current file): ", vim.fn.expand("%:p:h"), "file")
            end,
            pythonPath = function()
                if not is_empty(vim.env.CONDA_PREFIX) then
                    return vim.env.CONDA_PREFIX .. "/bin/python"
                else
                    return vim.fn.exepath("python")
                end
            end,
        },
        {
            -- The first three options are required by nvim-dap
            type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
            request = "launch",
            name = "Launch Python Debugger with args",
            -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
            console = "integratedTerminal",
            program = function()
                return vim.fn.input("Path to debuggee(default is current file): ", vim.fn.expand("%:p:h"), "file")
            end,
            args = function()
                return vim.split(vim.fn.input("Program arg(s) (enter nothing to leave it null): "), " ", { trimempty = true })
            end,
            pythonPath = function()
                if not is_empty(vim.env.CONDA_PREFIX) then
                    return vim.env.CONDA_PREFIX .. "/bin/python"
                else
                    return vim.fn.exepath("python")
                end
            end,
        },
        {
            type = "python",
            request = "launch",
            name = "Module",
            console = "integratedTerminal",
            module = function()
                return vim.fn.input("module path:")
            end,
            args = function()
                return vim.split(vim.fn.input("Program arg(s) (enter nothing to leave it null): "), " ", { trimempty = true })
            end,
            cwd = "${workspaceFolder}",
            pythonPath = function()
                if not is_empty(vim.env.CONDA_PREFIX) then
                    return vim.env.CONDA_PREFIX .. "/bin/python"
                else
                    return vim.fn.exepath("python")
                end
            end,
        },
    }
end
