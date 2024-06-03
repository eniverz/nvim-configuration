return function()
    local dap = require("dap")
    local dapui = require("dapui")

    local icons = { dap = require("config.icons").get("dap") }
    local colors = require("utils.color").get_palette()

    -- Initialize debug hooks
    _G._debugging = false
    local function debug_init_cb()
        _G._debugging = true
        dapui.open({ reset = true })
    end
    local function debug_terminate_cb()
        if _debugging then
            _G._debugging = false
            dapui.close()
        end
    end
    dap.listeners.after.event_initialized["dapui_config"] = debug_init_cb
    dap.listeners.before.event_terminated["dapui_config"] = debug_terminate_cb
    dap.listeners.before.event_exited["dapui_config"] = debug_terminate_cb
    dap.listeners.before.disconnect["dapui_config"] = debug_terminate_cb

    -- We need to override nvim-dap's default highlight groups, AFTER requiring nvim-dap for catppuccin.
    vim.api.nvim_set_hl(0, "DapStopped", { fg = colors.green })

    vim.fn.sign_define(
        "DapBreakpoint",
        { text = icons.dap.Breakpoint, texthl = "DapBreakpoint", linehl = "", numhl = "" }
    )
    vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = icons.dap.BreakpointCondition, texthl = "DapBreakpoint", linehl = "", numhl = "" }
    )
    vim.fn.sign_define("DapStopped", { text = icons.dap.Stopped, texthl = "DapStopped", linehl = "", numhl = "" })
    vim.fn.sign_define(
        "DapBreakpointRejected",
        { text = icons.dap.BreakpointRejected, texthl = "DapBreakpoint", linehl = "", numhl = "" }
    )
    vim.fn.sign_define("DapLogPoint", { text = icons.dap.LogPoint, texthl = "DapLogPoint", linehl = "", numhl = "" })
end
