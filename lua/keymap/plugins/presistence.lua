local bind = require("keymap.bind")
local map_callback = bind.map_callback

bind.nvim_load_mapping({
    ["n|<leader>ss"] = map_callback(function()
            local presistence = require("persistence")
            presistence.fire("SavePre")
            presistence.save()
            presistence.fire("SavePost")
        end)
        :with_noremap()
        :with_silent()
        :with_nowait()
        :with_desc("Session: save"),
    ["n|<leader>sl"] = map_callback(function()
            local presistence = require("persistence")
            presistence.load()
        end)
        :with_noremap()
        :with_silent()
        :with_nowait()
        :with_desc("Session: load current"),
    ["n|<leader>sL"] = map_callback(function()
            local presistence = require("persistence")
            presistence.load({ last = true })
        end)
        :with_noremap()
        :with_silent()
        :with_nowait()
        :with_desc("Session: load last"),
    ["n|<leader>sf"] = map_callback(function()
            local presistence = require("persistence")
            presistence.select()
        end)
        :with_noremap()
        :with_silent()
        :with_nowait()
        :with_desc("Session: select to load"),
    ["n|<leader>st"] = map_callback(function()
            local presistence = require("persistence")
            if presistence._active then
                presistence.stop()
            else
                presistence.start()
            end
        end)
        :with_noremap()
        :with_silent()
        :with_nowait()
        :with_desc("Session: toggle auto save"),
})
