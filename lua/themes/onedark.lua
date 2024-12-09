return {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function(_, opts)
        local scheme = require("config.scheme")
        local c = require("onedark.palette")[opts.style or "dark"]
        local lsp_kind_icons_color = {
            Default = c.purple,
            Array = c.yellow,
            Boolean = c.orange,
            Class = c.yellow,
            Color = c.green,
            Constant = c.orange,
            Constructor = c.blue,
            Enum = c.purple,
            EnumMember = c.yellow,
            Event = c.yellow,
            Field = c.purple,
            File = c.blue,
            Folder = c.orange,
            Function = c.blue,
            Interface = c.green,
            Key = c.cyan,
            Keyword = c.cyan,
            Method = c.blue,
            Module = c.orange,
            Namespace = c.red,
            Null = c.grey,
            Number = c.orange,
            Object = c.red,
            Operator = c.red,
            Package = c.yellow,
            Property = c.cyan,
            Reference = c.orange,
            Snippet = c.red,
            String = c.green,
            Struct = c.purple,
            Text = c.light_grey,
            TypeParameter = c.red,
            Unit = c.green,
            Value = c.orange,
            Variable = c.purple,
        }

        opts.highlights = opts.highlights or {}
        for kind, color in pairs(lsp_kind_icons_color) do
            opts.highlights["LspKind" .. kind] = { fg = color }
        end
        require("onedark").setup(vim.tbl_extend("force", opts, {
            transparent = scheme.transparent_background,
        }))
        if scheme.colorscheme:find("onedark") then
            vim.api.nvim_command("colorscheme " .. scheme.colorscheme)
        end
    end,
}
