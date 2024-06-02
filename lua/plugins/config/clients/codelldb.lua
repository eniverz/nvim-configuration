-- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)
return function()
    local dap = require("dap")
    local is_windows = require("config.global").is_windows

    dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
            command = vim.fn.exepath("codelldb"), -- Find codelldb on $PATH
            args = { "--port", "${port}" },
            detached = is_windows and false or true,
        },
    }
end
