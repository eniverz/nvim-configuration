local bind = require("keymap.bind")
local map_cmd = bind.map_cmd
local map_cr = bind.map_cr
local map_callback = bind.map_callback

local _lazygit = nil
_G._toggle_lazygit = function()
    if vim.fn.executable("lazygit") == 1 then
        if not _lazygit then
            _lazygit = require("toggleterm.terminal").Terminal:new({
                cmd = "lazygit",
                direction = "float",
                close_on_exit = true,
                hidden = true,
            })
        end
        _lazygit:toggle()
    else
        vim.notify("Command [lazygit] not found!", vim.log.levels.ERROR, { title = "toggleterm.nvim" })
    end
end

bind.nvim_load_mapping({
    ["t|<Esc><Esc>"] = map_cmd([[<C-\><C-n>]]):with_noremap():with_silent(), -- switch to normal mode in terminal.
    ["n|<leader>th"] = map_cr("ToggleTerm direction=horizontal")
        :with_noremap()
        :with_silent()
        :with_desc("terminal: Toggle horizontal"),
    ["i|<F4>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=horizontal<CR>")
        :with_noremap()
        :with_silent()
        :with_desc("terminal: Toggle horizontal"),
    ["t|<F4>"] = map_cmd("<Cmd>ToggleTerm<CR>"):with_noremap():with_silent():with_desc("terminal: Toggle horizontal"),
    ["n|<leader>tv"] = map_cr("ToggleTerm direction=vertical")
        :with_noremap()
        :with_silent()
        :with_desc("terminal: Toggle vertical"),
    ["i|<F3>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=vertical<CR>")
        :with_noremap()
        :with_silent()
        :with_desc("terminal: Toggle vertical"),
    ["t|<F3>"] = map_cmd("<Cmd>ToggleTerm<CR>"):with_noremap():with_silent():with_desc("terminal: Toggle vertical"),
    ["n|<leader>tf"] = map_cr("ToggleTerm direction=float")
        :with_noremap()
        :with_silent()
        :with_desc("terminal: Toggle float"),
    ["n|<F2>"] = map_cr("ToggleTerm direction=float"):with_noremap():with_silent():with_desc("terminal: Toggle float"),
    ["i|<F2>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=float<CR>")
        :with_noremap()
        :with_silent()
        :with_desc("terminal: Toggle float"),
    ["t|<A-d>"] = map_cmd("<Cmd>ToggleTerm<CR>"):with_noremap():with_silent():with_desc("terminal: Toggle float"),
    ["n|<leader>gg"] = map_callback(function()
            _toggle_lazygit()
        end)
        :with_noremap()
        :with_silent()
        :with_desc("git: Toggle lazygit"),
})
