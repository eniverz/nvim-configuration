local bind = require("keymap.bind")
local map_callback = bind.map_callback

local start = map_callback(function()
        require("dap").continue()
    end)
    :with_silent()
    :with_noremap()

local terminate = map_callback(function()
        require("dap").terminate()
    end)
    :with_silent()
    :with_noremap()

local condition_breakpoint = map_callback(function()
        vim.ui.input({ prompt = "Condition: " }, function(condition)
            if condition then
                require("dap").set_breakpoint(condition)
            end
        end)
    end)
    :with_silent()
    :with_noremap()

local restart = map_callback(function()
        require("dap").restart_frame()
    end)
    :with_silent()
    :with_noremap()

local toggle_breakpoint = map_callback(function()
        require("dap").toggle_breakpoint()
    end)
    :with_silent()
    :with_noremap()

local step_over = map_callback(function()
        require("dap").step_over()
    end)
    :with_silent()
    :with_noremap()

local step_into = map_callback(function()
        require("dap").step_into()
    end)
    :with_silent()
    :with_noremap()

local step_out = map_callback(function()
        require("dap").step_out()
    end)
    :with_silent()
    :with_noremap()

local dap_map = {
    ["n|<F21>"] = start:with_desc("dap: start/continue debug"), -- Shift + F9
    ["n|<C-F2>"] = terminate:with_desc("dap: stop debug"),
    ["n|<C-F5>"] = restart:with_desc("dap: restart"),
    ["n|<F9>"] = toggle_breakpoint:with_desc("dap: toggle breakpoint"),
    ["n|<F7>"] = step_into:with_desc("dap: step into"),
    ["n|<F8>"] = step_over:with_desc("dap: step over"),
    ["n|<F20>"] = step_out:with_desc("dap: step out"), -- Shift + F8

    ["n|<leader>db"] = toggle_breakpoint:with_desc("dap: toggle breakpoint(<F9>)"),
    ["n|<leader>dB"] = map_callback(function()
            require("dap").clear_breakpoints()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("dap: clear breakpoints"),
    ["n|<leader>dc"] = start:with_desc("dap: start/continue debug(<Shift-F9>)"),
    ["n|<leader>dC"] = condition_breakpoint:with_desc("dap: conditional breakpoint"),
    ["n|<leader>di"] = step_into:with_desc("dap: step into(<F7>)"),
    ["n|<leader>do"] = step_over:with_desc("dap: step over(<F8>)"),
    ["n|<leader>dO"] = step_out:with_desc("dap: step out(<Shift-F8>)"),
    ["n|<leader>dq"] = terminate:with_desc("dap: stop debug(<Ctrl-F2>)"),
    ["n|<leader>dr"] = restart:with_desc("dap: restart(<Ctrl-F5>)"),
    ["n|<leader>dR"] = map_callback(function()
            require("dap").repl.toggle()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("dap: toggle repl"),
    ["n|<leader>ds"] = map_callback(function()
            require("dap").run_to_cursor()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("dap: run to cursor"),
}

bind.nvim_load_mapping(dap_map)
