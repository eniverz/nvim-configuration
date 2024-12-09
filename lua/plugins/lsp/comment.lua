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
}
