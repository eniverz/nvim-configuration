local bind = require("keymap.bind")
local map_callback = bind.map_callback

bind.nvim_load_mapping({
    ["n|<leader>du"] = map_callback(function()
            require("dapui").toggle()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("dapui: toggle"),
    ["nv|<leader>dE"] = map_callback(function()
            vim.ui.input({ prompt = "Expression: " }, function(expr)
                if expr then
                    require("dapui").eval(expr, { enter = true })
                end
            end)
        end)
        :with_silent()
        :with_noremap()
        :with_desc("dap: eval expression"),
    ["n|<leader>dh"] = map_callback(function()
            require("dap.ui.widgets").hover()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("dap: debug hover"),
})
