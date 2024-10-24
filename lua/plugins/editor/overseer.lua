return {
    "stevearc/overseer.nvim",
    init = function()
        -- n <leader>ot <cmd>OverseerToggle<cr>
        -- n <leader>or <cmd>OverseerRun<cr>
    end,
    config = function()
        local overseer = require("overseer")
        overseer.setup({
            dap = false,
            templates = { "make", "cargo", "shell", "user.run_python" },
            task_list = {
                direction = "left",
                bindings = {
                    ["<C-v>"] = false,
                    ["<C-d>"] = false,
                    ["<C-h>"] = false,
                    ["<C-j>"] = false,
                    ["<C-k>"] = false,
                    ["<C-l>"] = false,
                },
            },
        })

        overseer.add_template_hook({
            module = "^make$",
        }, function(task_defn, util)
            util.add_component(task_defn, { "on_output_quickfix", open_on_exit = "failure" })
            util.add_component(task_defn, "on_complete_notify")
            util.add_component(task_defn, { "display_duration", detail_level = 1 })
        end)
    end,
}
