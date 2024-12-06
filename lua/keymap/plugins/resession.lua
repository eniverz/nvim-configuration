local bind = require("keymap.bind")
local map_callback = bind.map_callback

bind.nvim_load_mapping({
    ["n|<leader>sl"] = map_callback(function()
            require("resession").load(vim.fn.getcwd(), { dir = require("config.settings").sessions.save_dir, silence_errors = true })
        end)
        :with_noremap()
        :with_nowait()
        :with_silent()
        :with_desc("Resession: load session for current path"),
    ["n|<leader>ss"] = map_callback(function()
            require("resession").save(vim.fn.getcwd(), { dir = require("config.settings").sessions.save_dir, notify = true })
        end)
        :with_noremap()
        :with_nowait()
        :with_silent()
        :with_desc("Resession: save session for current path"),
    ["n|<leader>sd"] = map_callback(function()
            require("resession").delete(vim.fn.getcwd(), { dir = require("config.settings").sessions.save_dir, notify = true })
        end)
        :with_noremap()
        :with_nowait()
        :with_silent()
        :with_desc("Resession: delete session for current path"),
})
