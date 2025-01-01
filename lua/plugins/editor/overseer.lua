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
}
