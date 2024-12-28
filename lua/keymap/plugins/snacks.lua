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
        :with_desc("Snacks: open lazygit commit log panel"),
    ["n|<leader>gb"] = map_callback(function()
            Snacks.git.blame_line()
        end)
        :with_noremap()
        :with_nowait()
        :with_silent()
        :with_desc("Snacks: show commit history in current line"),

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

    ["n|<leader>tf"] = map_callback(function()
            Snacks.terminal.toggle()
        end)
        :with_noremap()
        :with_silent()
        :with_desc("Snacks: open float terminal"),
    ["n|<leader>th"] = map_callback(function()
            ---@diagnostic disable-next-line:missing-fields
            Snacks.terminal.toggle(nil, { win = { position = "bottom", height = 0.4 }, env = { NVIM_TERM = "horizontal" } })
        end)
        :with_noremap()
        :with_silent()
        :with_nowait()
        :with_desc("Snacks: open horizontal terminal"),
    ["n|<leader>tv"] = map_callback(function()
            ---@diagnostic disable-next-line:missing-fields
            Snacks.terminal.toggle(nil, { win = { position = "right", width = 0.4 }, env = { NVIM_TERM = "vertical" } })
        end)
        :with_noremap()
        :with_silent()
        :with_nowait()
        :with_desc("Snacks: open horizontal terminal"),
})

Snacks.toggle.diagnostics():map("<leader>uD")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
Snacks.toggle.treesitter():map("<leader>ut")
Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
Snacks.toggle.indent():map("<leader>u|")
Snacks.toggle.zen():map("<leader>uz")
