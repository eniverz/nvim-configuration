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

    dap.configurations.c = {
        {
            name = "Debug",
            type = "codelldb",
            request = "launch",
            program = function()
                return vim.fn.input('Path to executable (default to "a.out"): ', vim.fn.expand("%:p:h") .. "/a.out", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            terminal = "integrated",
        },
        {
            name = "CMake with CLion format",
            type = "codelldb",
            request = "launch",
            program = function()
                return vim.fn.input("Path to executable (in cmake-build-debug): ", vim.fn.expand("%:p:h") .. "/cmake-build-debug/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            terminal = "integrated",
        },
        {
            name = "Debug (with args)",
            type = "codelldb",
            request = "launch",
            program = function()
                return vim.fn.input('Path to executable (default to "a.out"): ', vim.fn.expand("%:p:h") .. "/a.out", "file")
            end,
            args = function()
                return vim.split(vim.fn.input("Program arg(s) (enter nothing to leave it null): "), " ", { trimempty = true })
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            terminal = "integrated",
        },
        {
            name = "Attach to a running process",
            type = "codelldb",
            request = "attach",
            program = function()
                return vim.fn.input('Path to executable (default to "a.out"): ', vim.fn.expand("%:p:h") .. "/a.out", "file")
            end,
            stopOnEntry = false,
            waitFor = true,
        },
    }
    dap.configurations.cpp = dap.configurations.c

    dap.configurations.rust = {
        {
            name = "Debug",
            type = "codelldb",
            request = "launch",
            program = function()
                return vim.fn.input("Path to executable (in target/debug): ", vim.fn.expand("%:p:h") .. "/target/debug/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            terminal = "integrated",
        },
        {
            name = "Debug (with args)",
            type = "codelldb",
            request = "launch",
            program = function()
                return vim.fn.input("Path to executable (in target/debug): ", vim.fn.expand("%:p:h") .. "/target/debug/", "file")
            end,
            args = function()
                return vim.split(vim.fn.input("Program arg(s) (enter nothing to leave it null): "), " ", { trimempty = true })
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            terminal = "integrated",
        },
        {
            name = "Attach to a running process",
            type = "codelldb",
            request = "attach",
            program = function()
                return vim.fn.input("Path to executable (in target/debug): ", vim.fn.expand("%:p:h") .. "/target/debug/", "file")
            end,
            stopOnEntry = false,
            waitFor = true,
        },
    }
end
