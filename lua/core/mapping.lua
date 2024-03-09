local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback

local core_map = {
    -- Suckless
    ["n|<S-Tab>"] = map_cr("normal za"):with_noremap():with_silent():with_desc("edit: Toggle code fold"),
    ["n|<C-s>"] = map_cu("write"):with_noremap():with_silent():with_desc("edit: Save file"),
    ["n|Y"] = map_cmd("y$"):with_desc("edit: Yank text to EOL"),
    ["n|D"] = map_cmd("d$"):with_desc("edit: Delete text to EOL"),
    ["n|n"] = map_cmd("nzzzv"):with_noremap():with_desc("edit: Next search result"),
    ["n|N"] = map_cmd("Nzzzv"):with_noremap():with_desc("edit: Prev search result"),
    ["n|J"] = map_cmd("mzJ`z"):with_noremap():with_desc("edit: Join next line"),
    ["n|<Esc>"] = map_callback(function()
            _flash_esc_or_noh()
        end)
        :with_noremap()
        :with_silent()
        :with_desc("edit: Clear search highlight"),
    ["t|<leader>wa"] = map_cmd("<Cmd>wincmd h<CR>"):with_silent():with_noremap():with_desc("window: Focus left"),
    ["t|<leader>wd"] = map_cmd("<Cmd>wincmd l<CR>"):with_silent():with_noremap():with_desc("window: Focus right"),
    ["t|<leader>ws"] = map_cmd("<Cmd>wincmd j<CR>"):with_silent():with_noremap():with_desc("window: Focus down"),
    ["t|<leader>ww"] = map_cmd("<Cmd>wincmd k<CR>"):with_silent():with_noremap():with_desc("window: Focus up"),
    ["n|<leader>w["] = map_cr("vertical resize -5"):with_silent():with_desc("window: Resize -5 vertically"),
    ["n|<leader>w]"] = map_cr("vertical resize +5"):with_silent():with_desc("window: Resize +5 vertically"),
    ["n|<leader>w="] = map_cr("resize -2"):with_silent():with_desc("window: Resize -2 horizontally"),
    ["n|<leader>w-"] = map_cr("resize +2"):with_silent():with_desc("window: Resize +2 horizontally"),
    ["n|<A-q>"] = map_cr("wq"):with_desc("edit: Save file and quit"),
    ["n|<A-S-q>"] = map_cr("q!"):with_desc("edit: Force quit"),
    ["n|<leader>o"] = map_cr("setlocal spell! spelllang=en_us"):with_desc("edit: Toggle spell check"),
    -- Insert mode
    ["i|<C-s>"] = map_cmd("<Esc>:w<CR>"):with_desc("edit: Save file"),
    ["i|<A-q>"] = map_cmd("<Esc>:wq<CR>"):with_desc("edit: Save file and quit"),
    -- Command mode
    ["c|<C-t>"] = map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]])
        :with_noremap()
        :with_desc("edit: Complete path of current file"),
    -- Visual mode
    ["v|J"] = map_cmd(":m '>+1<CR>gv=gv"):with_desc("edit: Move this line down"),
    ["v|K"] = map_cmd(":m '<-2<CR>gv=gv"):with_desc("edit: Move this line up"),
    ["v|<"] = map_cmd("<gv"):with_desc("edit: Decrease indent"),
    ["v|>"] = map_cmd(">gv"):with_desc("edit: Increase indent"),
}

bind.nvim_load_mapping(core_map)
