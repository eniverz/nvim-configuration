local bind = require("keymap.bind")
local map_callback = bind.map_callback

bind.nvim_load_mapping({
    -- notifier
    ["n|<leader>ud"] = map_callback(function()
            Snacks.notifier.hide()
        end)
        :with_noremap()
        :with_nowait()
        :with_silent()
        :with_desc("Snacks: clear all notifications"),
    ["n|<leader>un"] = map_callback(function()
            Snacks.notifier.show_history()
        end)
        :with_noremap()
        :with_nowait()
        :with_silent()
        :with_desc("Snacks: show notifications history"),

    -- lazygit
    ["n|<leader>gg"] = map_callback(function()
            Snacks.lazygit.open()
        end)
        :with_noremap()
        :with_nowait()
        :with_silent()
        :with_desc("Snacks: open lazygit panel"),
    ["n|<leader>gl"] = map_callback(function()
            Snacks.lazygit.log()
        end)
        :with_noremap()
        :with_nowait()
        :with_silent()
        :with_desc("Snacks: open lazygit panel"),
    ["n|<leader>gb"] = map_callback(function()
            Snacks.git.blame_line()
        end)
        :with_noremap()
        :with_nowait()
        :with_silent()
        :with_desc("Snacks: open lazygit panel"),

    -- word jumps
    ["nt|]]"] = map_callback(function()
            Snacks.words.jump(vim.v.count1)
        end)
        :with_noremap()
        :with_nowait()
        :with_silent()
        :with_desc("Snacks: jump next word"),
    ["nt|[["] = map_callback(function()
            Snacks.words.jump(-vim.v.count1)
        end)
        :with_noremap()
        :with_nowait()
        :with_silent()
        :with_desc("Snacks: jump next word"),
})
