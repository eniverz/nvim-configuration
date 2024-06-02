local bind = require("keymap.bind")
local map_callback = bind.map_callback

bind.nvim_load_mapping({
    ["n|<leader>zR"] = map_callback(function()
            require("ufo").openAllFolds()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("ufo: open all folds"),
    ["n|<leader>zr"] = map_callback(function()
            require("ufo").openFoldsExceptKinds()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("ufo: fold less"),
    ["n|<leader>zM"] = map_callback(function()
            require("ufo").closeAllFolds()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("ufo: close all folds"),
    ["n|<leader>zm"] = map_callback(function()
            require("ufo").closeFoldsWith()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("ufo: fold more"),
    ["n|<leader>zp"] = map_callback(function()
            require("ufo").peekFoldedLinesUnderCursor()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("ufo: peel fold"),
})
