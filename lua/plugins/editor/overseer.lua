-- task runner
return {
    "stevearc/overseer.nvim",
    cmd = { "OverseerInfo", "OverseerRunCmd", "OverseerRun", "OverseerToggle" },
    opts = {
        templates = { "custom" },
        template_dirs = { "config.overseer" },
        task_list = {
            max_width = 0.35,
            min_width = 0.35,
            direction = "right",
            bindings = {
                ["{"] = "DecreaseWidth",
                ["}"] = "IncreaseWidth",
                ["["] = "PrevTask",
                ["]"] = "NextTask",
            },
        },
    },
    keys = {
        {
            "<leader>or",
            function()
                require("overseer").run_template({})
            end,
            desc = "Overseer: run task",
        },
        { "<leader>oc", ":OverseerRunCmd<CR>", desc = "Overseer: run command" },
        { "<leader>oc", ":OverseerToggle<CR>", desc = "Overseer: toggle task list" },
        { "<leader>oc", ":OverseerInfo<CR>", desc = "Overseer: show info" },
    },
}
