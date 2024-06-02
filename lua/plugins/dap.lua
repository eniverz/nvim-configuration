return {
    "mfussenegger/nvim-dap",
    lazy = true,
    cmd = {
        "DapSetLogLevel",
        "DapShowLog",
        "DapContinue",
        "DapToggleBreakpoint",
        "DapToggleRepl",
        "DapStepOver",
        "DapStepInto",
        "DapStepOut",
        "DapTerminate",
    },
    config = require("plugins.config.dap"),
    dependencies = {
        {
            "jay-babu/mason-nvim-dap.nvim",
            dependencies = { "nvim-dap", "williamboman/mason.nvim" },
            init = function(plugin) require("utils.core").on_load("mason.nvim", plugin.name) end,
            cmd = { "DapInstall", "DapUninstall" },
            opts = { ensure_installed = {}, handlers = {} },
        },
        {
            "rcarriga/nvim-dap-ui",
            lazy = true,
            dependencies = {
                { "nvim-neotest/nvim-nio", lazy = true },
            },
            opts = { floating = { border = "rounded" } },
            config = function(...) require "plugins.config.dapui" (...) end,
        },
        {
            "rcarriga/cmp-dap",
            lazy = true,
            dependencies = { "hrsh7th/nvim-cmp" },
            config = function(...) require "plugins.config.cmp_dap" (...) end,
        },
    },
}
