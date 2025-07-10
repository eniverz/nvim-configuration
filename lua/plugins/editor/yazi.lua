-- file explorer
return {
    "mikavilpas/yazi.nvim",
    cmd = "Yazi",
    opts = {
        highlight_groups = { hovered_buffer = {} },
        highlight_hovered_buffers_in_same_directory = false,
        floating_window_scaling_factor = 0.6,
        keymaps = false,
        open_multiple_tabs = true,
    },
    keys = {
        {"<leader>e", "<Cmd>Yazi<CR>", desc = "Yazi: toggle with current file"},
        {"<leader>n", "<Cmd>Yazi cwd<CR>", desc = "Yazi: toggle with current working directory"}
    }
}
