-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#python
-- https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
return function()
    local dap = require("dap")
    local debugpy = vim.fn.exepath("debugpy-adapter")

    dap.adapters.python = function(callback, config)
        if config.request == "attach" then
            local port = (config.connect or config).port
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
end
