return {
    "gbprod/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function(_, opts)
        local scheme = require("config.scheme")
        opts.transparent = scheme.transparent_background
        opts.on_highlights = function(highlights, colors)
            local lsp_kind_icons_color = {
                Default = colors.aurora.purple,
                Array = colors.aurora.yellow,
                Boolean = colors.aurora.orange,
                Class = colors.aurora.yellow,
                Color = colors.aurora.green,
                Constant = colors.aurora.orange,
                Constructor = colors.frost.artic_ocean,
                Enum = colors.aurora.purple,
                EnumMember = colors.aurora.yellow,
                Event = colors.aurora.yellow,
                Field = colors.aurora.purple,
                File = colors.frost.artic_ocean,
                Folder = colors.aurora.orange,
                Function = colors.frost.artic_ocean,
                Interface = colors.aurora.green,
                Key = colors.frost.ice,
                Keyword = colors.frost.ice,
                Method = colors.frost.artic_ocean,
                Module = colors.aurora.orange,
                Namespace = colors.aurora.red,
                Null = colors.polar_night.light,
                Number = colors.aurora.orange,
                Object = colors.aurora.red,
                Operator = colors.aurora.red,
                Package = colors.aurora.yellow,
                Property = colors.frost.ice,
                Reference = colors.aurora.orange,
                Snippet = colors.aurora.red,
                String = colors.aurora.green,
                Struct = colors.aurora.purple,
                Text = colors.polar_night.light,
                TypeParameter = colors.aurora.red,
                Unit = colors.aurora.green,
                Value = colors.aurora.orange,
                Variable = colors.aurora.purple,
            }
            for kind, color in pairs(lsp_kind_icons_color) do
                highlights["LspKind" .. kind] = { fg = color }
            end
            local hl_override = scheme.highlight_overrides
            for name, hl in pairs(hl_override) do
                highlights[name] = hl
            end
        end

        if scheme.colorscheme:find("nord") then
            vim.api.nvim_command("colorscheme " .. scheme.colorscheme)
        end
        require("nord").setup(opts)
    end,
}
