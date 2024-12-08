local bind = require("keymap.bind")
local map_cr = bind.map_cr

bind.nvim_load_mapping({
    ["n|<A-Left>"] = map_cr("BufferPrevious"):with_noremap():with_silent():with_nowait():with_desc("Buffer: previous"),
    ["n|<A-Right>"] = map_cr("BufferNext"):with_noremap():with_silent():with_nowait():with_desc("Buffer: next"),
    ["n|<A-j>"] = map_cr("BufferPrevious"):with_noremap():with_silent():with_nowait():with_desc("Buffer: previous"),
    ["n|<A-k>"] = map_cr("BufferNext"):with_noremap():with_silent():with_nowait():with_desc("Buffer: next"),
    ["n|<A-S-Left>"] = map_cr("BufferMovePrevious"):with_noremap():with_silent():with_nowait():with_desc("Buffer: moveprevious"),
    ["n|<A-S-Right>"] = map_cr("BufferMoveNext"):with_noremap():with_silent():with_nowait():with_desc("Buffer: move next"),
    ["n|<A-S-j>"] = map_cr("BufferMovePrevious"):with_noremap():with_silent():with_nowait():with_desc("Buffer: move previous"),
    ["n|<A-S-k>"] = map_cr("BufferMoveNext"):with_noremap():with_silent():with_nowait():with_desc("Buffer: move next"),
    ["n|<leader>bG"] = map_cr("BufferLast"):with_noremap():with_silent():with_nowait():with_desc("Buffer: go last"),
    ["n|<leader>bp"] = map_cr("BufferPick"):with_noremap():with_silent():with_nowait():with_desc("Buffer: pick one buffer"),

    ["n|<leader>bP"] = map_cr("BufferPin"):with_noremap():with_silent():with_nowait():with_desc("Buffer: pin/unpin current"),
    ["n|<leader>c"] = map_cr("BufferClose"):with_noremap():with_silent():with_nowait():with_desc("Buffer: close current"),
    ["n|<leader>bc"] = map_cr("BufferCloseAllButCurrentOrPinned"):with_noremap():with_silent():with_nowait():with_desc("Buffer: close all except current"),
    ["n|<leader>bl"] = map_cr("BufferCloseBufferLeft"):with_noremap():with_silent():with_nowait():with_desc("Buffer: close left buffer"),
    ["n|<leader>br"] = map_cr("BufferCloseBufferRight"):with_noremap():with_silent():with_nowait():with_desc("Buffer: close right buffer"),
    ["n|<leader>bR"] = map_cr("BufferRestore"):with_noremap():with_silent():with_nowait():with_desc("Buffer: restore closed"),

    ["n|<leader>bsi"] = map_cr("BufferOrderByBufferNumber"):with_noremap():with_silent():with_nowait():with_desc("Buffer: sort by buffer id"),
    ["n|<leader>bsn"] = map_cr("BufferOrderByName"):with_noremap():with_silent():with_nowait():with_desc("Buffer: sort by name"),
    ["n|<leader>bsd"] = map_cr("BufferOrderByDirectory"):with_noremap():with_silent():with_nowait():with_desc("Buffer: sort by directory"),
    ["n|<leader>bsl"] = map_cr("BufferOrderByLanguage"):with_noremap():with_silent():with_nowait():with_desc("Buffer: sort by code language"),
    ["n|<leader>bsw"] = map_cr("BufferOrderByWindowNumber"):with_noremap():with_silent():with_nowait():with_desc("Buffer: sort by window number"),
})
