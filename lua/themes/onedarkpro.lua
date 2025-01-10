return {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000,
    config = function(_, opts)
        local scheme = require("config.scheme")
        opts.highlights = vim.tbl_extend("force", opts.highlights or {}, scheme.highlight_overrides)
        local colors = require("onedarkpro.theme").colors(scheme.colorscheme:find("onedark") and scheme.colorscheme or "onedark_dark")
        local lsp_kind_icons_color = {
            Default = colors.purple,
            Array = colors.yellow,
            Boolean = colors.orange,
            Class = colors.yellow,
            Color = colors.green,
            Constant = colors.orange,
            Constructor = colors.blue,
            Enum = colors.purple,
            EnumMember = colors.yellow,
            Event = colors.yellow,
            Field = colors.purple,
            File = colors.blue,
            Folder = colors.orange,
            Function = colors.blue,
            Interface = colors.green,
            Key = colors.cyan,
            Keyword = colors.cyan,
            Method = colors.blue,
            Module = colors.orange,
            Namespace = colors.red,
            Null = colors.grey,
            Number = colors.orange,
            Object = colors.red,
            Operator = colors.red,
            Package = colors.yellow,
            Property = colors.cyan,
            Reference = colors.orange,
            Snippet = colors.red,
            String = colors.green,
            Struct = colors.purple,
            Text = colors.grey,
            TypeParameter = colors.red,
            Unit = colors.green,
            Value = colors.orange,
            Variable = colors.purple,
        }
        for kind, color in pairs(lsp_kind_icons_color) do
            opts.highlights["LspKind" .. kind] = { fg = color }
        end
        opts.options = vim.tbl_extend("force", opts.options or {}, {
            cursorline = true,
            transparency = scheme.transparent_background,
        })

        if scheme.colorscheme:find("onedark") then
            vim.api.nvim_command("colorscheme " .. scheme.colorscheme)
        end
        require("onedarkpro").setup(opts)
    end,
}
