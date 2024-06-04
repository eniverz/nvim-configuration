-- debug tool
return {
    {
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
                dependencies = { "williamboman/mason.nvim" },
                init = function(plugin)
                    require("utils.core").on_load("mason.nvim", plugin.name)
                end,
                cmd = { "DapInstall", "DapUninstall" },
                opts = {
                    handlers = {
                        function(config)
                            local dap_name = config.name
                            local ok, custom_handler = pcall(require, "plugins.config.clients." .. dap_name)
                            if not ok then
                                -- Default to use factory config for clients(s) that doesn't include a spec
                                require("mason-nvim-dap").default_setup(config)
                                return
                            elseif type(custom_handler) == "function" then
                                -- Case where the protocol requires its own setup
                                -- Make sure to set
                                -- * dap.adpaters.<dap_name> = { your config }
                                -- * dap.configurations.<lang> = { your config }
                                -- See `codelldb.lua` for a concrete example.
                                custom_handler(config)
                            else
                                vim.notify(
                                    string.format(
                                        "Failed to setup [%s].\n\nClient definition under `tool/dap/clients` must return\na fun(opts) (got '%s' instead)",
                                        config.name,
                                        type(custom_handler)
                                    ),
                                    vim.log.levels.ERROR,
                                    { title = "nvim-dap" }
                                )
                            end
                        end,
                    },
                },
                config = function(_, opts)
                    require("mason-nvim-dap").setup(opts)
                end,
            },
            {
                "rcarriga/nvim-dap-ui",
                lazy = true,
                dependencies = {
                    { "nvim-neotest/nvim-nio", lazy = true },
                },
                opts = { floating = { border = "rounded" } },
                config = function(...)
                    require("plugins.config.dapui")(...)
                end,
            },
            {
                "rcarriga/cmp-dap",
                lazy = true,
                dependencies = { "hrsh7th/nvim-cmp" },
                config = function(...)
                    require("plugins.config.cmp_dap")(...)
                end,
            },
            {
                "theHamsta/nvim-dap-virtual-text",
                lazy = true,
                opts = {
                    enabled = true, -- enable this plugin (the default)
                    enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
                    highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
                    highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
                    show_stop_reason = true, -- show stop reason when stopped for exceptions
                    commented = false, -- prefix virtual text with comment string
                    only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
                    all_references = false, -- show virtual text on all all references of the variable (not only definitions)
                    clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
                    --- A callback that determines how a variable is displayed or whether it should be omitted
                    --- @param variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
                    --- @param buf number
                    --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
                    --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
                    --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
                    --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
                    display_callback = function(variable, buf, stackframe, node, options)
                        if options.virt_text_pos == "inline" then
                            return " = " .. variable.value
                        else
                            return variable.name .. " = " .. variable.value
                        end
                    end,
                    -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
                    virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",

                    -- experimental features:
                    all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
                    virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
                    virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
                    -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
                },
                config = function(_, opts)
                    require("nvim-dap-virtual-text").setup(opts)
                end,
            },
        },
    },
    {
        "catppuccin",
        optional = true,
        ---@type CatppuccinOptions
        opts = {
            integrations = { dap = true, dap_ui = true },
        },
    },
}
