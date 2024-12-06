local bind = require("keymap.bind")
local map_callback = bind.map_callback

bind.nvim_load_mapping({
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
})
