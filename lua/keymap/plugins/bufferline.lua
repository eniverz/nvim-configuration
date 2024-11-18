local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_callback = bind.map_callback

bind.nvim_load_mapping({
    ["n|<A-S-j>"] = map_cr("BufferLineMovePrev"):with_noremap():with_silent():with_desc("buffer: Move current to prev"),
    ["n|<A-S-k>"] = map_cr("BufferLineMoveNext"):with_noremap():with_silent():with_desc("buffer: Move current to next"),
    ["n|<A-Left>"] = map_cr("BufferLineCyclePrev"):with_noremap():with_silent():with_desc("buffer: Switch to prev"),
    ["n|<A-Right>"] = map_cr("BufferLineCycleNext"):with_noremap():with_silent():with_desc("buffer: Switch to next"),
    ["n|<A-j>"] = map_cr("BufferLineCyclePrev"):with_noremap():with_silent():with_desc("buffer: Switch to prev"),
    ["n|<A-k>"] = map_cr("BufferLineCycleNext"):with_noremap():with_silent():with_desc("buffer: Switch to next"),
    ["n|<leader>c"] = map_callback(function()
            require("utils.buffer").close()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("edit: close current buffer"),
    ["n|<leader>bc"] = map_callback(function()
            require("bufferline").close_others()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("edit: close all except current buffer"),
    ["n|<leader>bl"] = map_callback(function()
            require("bufferline").close_in_direction("left")
        end)
        :with_silent()
        :with_noremap()
        :with_desc("edit: close all buffer at left"),
    ["n|<leader>br"] = map_callback(function()
            require("bufferline").close_in_direction("right")
        end)
        :with_silent()
        :with_noremap()
        :with_desc("edit: close all buffer at right"),
    ["n|<leader>bC"] = map_callback(function()
            require("utils.buffer").close_all()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("edit: close all buffers"),
    ["n|<leader>be"] = map_cr("BufferLineSortByExtension"):with_noremap():with_desc("buffer: Sort by extension"),
    ["n|<leader>bd"] = map_cr("BufferLineSortByDirectory"):with_noremap():with_desc("buffer: Sort by direrctory"),
    ["n|<A-1>"] = map_cr("BufferLineGoToBuffer 1"):with_noremap():with_silent():with_desc("buffer: Goto buffer 1"),
    ["n|<A-2>"] = map_cr("BufferLineGoToBuffer 2"):with_noremap():with_silent():with_desc("buffer: Goto buffer 2"),
    ["n|<A-3>"] = map_cr("BufferLineGoToBuffer 3"):with_noremap():with_silent():with_desc("buffer: Goto buffer 3"),
    ["n|<A-4>"] = map_cr("BufferLineGoToBuffer 4"):with_noremap():with_silent():with_desc("buffer: Goto buffer 4"),
    ["n|<A-5>"] = map_cr("BufferLineGoToBuffer 5"):with_noremap():with_silent():with_desc("buffer: Goto buffer 5"),
    ["n|<A-6>"] = map_cr("BufferLineGoToBuffer 6"):with_noremap():with_silent():with_desc("buffer: Goto buffer 6"),
    ["n|<A-7>"] = map_cr("BufferLineGoToBuffer 7"):with_noremap():with_silent():with_desc("buffer: Goto buffer 7"),
    ["n|<A-8>"] = map_cr("BufferLineGoToBuffer 8"):with_noremap():with_silent():with_desc("buffer: Goto buffer 8"),
    ["n|<A-9>"] = map_cr("BufferLineGoToBuffer 9"):with_noremap():with_silent():with_desc("buffer: Goto buffer 9"),
})
