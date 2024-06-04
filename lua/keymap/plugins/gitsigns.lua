local bind = require("keymap.bind")

return function(buf)
    local actions = require("gitsigns.actions")
    local maps = {
        ["n|]g"] = bind.map_callback(function()
            if vim.wo.diff then
                return "]g"
            end
            vim.schedule(function()
                actions.nav_hunk("next")
            end)
            return "<Ignore>"
        end)
            :with_buffer(buf)
            :with_expr()
            :with_desc("git: Goto next hunk"),
        ["n|[g"] = bind.map_callback(function()
            if vim.wo.diff then
                return "[g"
            end
            vim.schedule(function()
                actions.nav_hunk("prev")
            end)
            return "<Ignore>"
        end)
            :with_buffer(buf)
            :with_expr()
            :with_desc("git: Goto prev hunk"),
        ["n|<leader>gs"] = bind.map_callback(function()
            actions.stage_hunk()
        end)
            :with_buffer(buf)
            :with_desc("git: Stage hunk"),
        ["v|<leader>gs"] = bind.map_callback(function()
            actions.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
            :with_buffer(buf)
            :with_desc("git: Stage hunk"),
        ["n|<leader>gu"] = bind.map_callback(function()
            actions.undo_stage_hunk()
        end)
            :with_buffer(buf)
            :with_desc("git: Undo stage hunk"),
        ["n|<leader>gr"] = bind.map_callback(function()
            actions.reset_hunk()
        end)
            :with_buffer(buf)
            :with_desc("git: Reset hunk"),
        ["v|<leader>gr"] = bind.map_callback(function()
            actions.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
            :with_buffer(buf)
            :with_desc("git: Reset hunk"),
        ["n|<leader>gR"] = bind.map_callback(function()
            actions.reset_buffer()
        end)
            :with_buffer(buf)
            :with_desc("git: Reset buffer"),
        ["n|<leader>gh"] = bind.map_callback(function()
            actions.preview_hunk()
        end)
            :with_buffer(buf)
            :with_desc("git: Preview hunk"),
        ["n|<leader>gB"] = bind.map_callback(function()
            actions.blame_line({ full = true })
        end)
            :with_buffer(buf)
            :with_desc("git: Blame line"),
        -- Text objects
        ["ox|ih"] = bind.map_callback(function()
            actions.text_object()
        end):with_buffer(buf),
    }
    bind.nvim_load_mapping(maps)
end
