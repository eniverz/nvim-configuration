-- quick make comment
return {
    "numToStr/Comment.nvim",
    event = { "CursorHold", "CursorHoldI" },
    lazy = true,
    opts = function(_, opts)
        local commentstring_avail, commentstring = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
        if commentstring_avail then
            opts.pre_hook = commentstring.create_pre_hook()
        end
    end,
    keys = {
        {"<C-/>", function()
            return require("Comment.api").call(
                "toggle.linewise." .. (vim.v.count == 0 and "current" or "count_repeat"),
                "g@$"
            )()
        end, desc = "Comment: toggle line", expr = true},
        {"<C-_>", function()
            return require("Comment.api").call(
                "toggle.linewise." .. (vim.v.count == 0 and "current" or "count_repeat"),
                "g@$"
            )()
        end, desc = "Comment: toggle line", expr = true},
        {"<leader>/", function()
            return require("Comment.api").call(
                "toggle.linewise." .. (vim.v.count == 0 and "current" or "count_repeat"),
                "g@$"
            )()
        end, desc = "Comment: toggle line", expr = true},
        {"<leader>/", "<Esc><Cmd>lua require('Comment.api').locked('toggle.linewise')(vim.fn.visualmode())<CR>", mode = "x", desc = "Comment: toggle select lines"},
        {"<C-_>", "<Esc><Cmd>lua require('Comment.api').locked('toggle.linewise')(vim.fn.visualmode())<CR>", mode = "x", desc = "Comment: toggle select lines"},
        {"<C-/>", "<Esc><Cmd>lua require('Comment.api').locked('toggle.linewise')(vim.fn.visualmode())<CR>", mode = "x", desc = "Comment: toggle select lines"},
    }
}
