-- multicursor
return {
    "mg979/vim-visual-multi",
    init = function()
        vim.g.VM_default_mappings = 0
    end,
    keys = {
        { "<A-Down>", "<Plug>(VM-Add-Cursor-Down)", desc = "Visual Multi: Add cursor down" },
        { "<A-Up>", "<Plug>(VM-Add-Cursor-Up)", desc = "Visual Multi: Add cursor up" },
    }
}
