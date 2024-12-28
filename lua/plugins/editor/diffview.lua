-- show better git diff
return {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    opts = function()
        local actions = require("diffview.actions")

        return {
            keymaps = {
                file_panel = {
                    { "n", "<leader>do", actions.conflict_choose_all("ours"), { desc = "Choose the OURS version of a conflict for the whole file" } },
                    { "n", "<leader>dt", actions.conflict_choose_all("theirs"), { desc = "Choose the THEIRS version of a conflict for the whole file" } },
                    { "n", "<leader>db", actions.conflict_choose_all("base"), { desc = "Choose the BASE version of a conflict for the whole file" } },
                    { "n", "<leader>da", actions.conflict_choose_all("all"), { desc = "Choose all the versions of a conflict for the whole file" } },
                },
            },
        }
    end,
}
