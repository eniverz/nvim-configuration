return {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000,
    config = function(_, opts)
        local scheme = require("config.scheme")
        opts.highlights = vim.tbl_extend("force", opts.highlights or {}, scheme.highlight_overrides)
        local colors = require("onedarkpro.theme").colors(scheme.colorscheme:find("onedark") and scheme.colorscheme or "onedark_vivid")
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
            Null = colors.gray,
            Number = colors.orange,
            Object = colors.red,
            Operator = colors.red,
            Package = colors.yellow,
            Property = colors.cyan,
            Reference = colors.orange,
            Snippet = colors.red,
            String = colors.green,
            Struct = colors.purple,
            Text = colors.gray,
            TypeParameter = colors.red,
            Unit = colors.green,
            Value = colors.orange,
            Variable = colors.purple,
        }
        for kind, color in pairs(lsp_kind_icons_color) do
            opts.highlights["LspKind" .. kind] = { fg = color }
        end
        local blink_cmp_hls = {
            BlinkCmpMenuBorder = { fg = colors.gray },
            BlinkCmpMenuSelection = { fg = colors.none, bg = colors.comment },
            BlinkCmpLabelDeprecated = { fg = colors.comment },
            BlinkCmpLabelMatch = { fg = colors.cyan, bold = true },
            BlinkCmpGhostText = { fg = colors.comment },
            BlinkCmpDocBorder = { fg = colors.gray },
            BlinkCmpSignatureHelpBorder = { fg = colors.gray },
            BlinkCmpKindArray = { fg = colors.yellow },
            BlinkCmpKindBoolean = { fg = colors.orange },
            BlinkCmpKindClass = { fg = colors.yellow },
            BlinkCmpKindColor = { fg = colors.red },
            BlinkCmpKindConstant = { fg = colors.orange },
            BlinkCmpKindConstructor = { fg = colors.blue },
            BlinkCmpKindEnum = { fg = colors.purple },
            BlinkCmpKindEnumMember = { fg = colors.yellow },
            BlinkCmpKindEvent = { fg = colors.yellow },
            BlinkCmpKindField = { fg = colors.purple },
            BlinkCmpKindFile = { fg = colors.blue },
            BlinkCmpKindFolder = { fg = colors.orange },
            BlinkCmpKindFunction = { fg = colors.blue },
            BlinkCmpKindInterface = { fg = colors.green },
            BlinkCmpKindKey = { fg = colors.cyan },
            BlinkCmpKindKeyword = { fg = colors.cyan },
            BlinkCmpKindMethod = { fg = colors.blue },
            BlinkCmpKindModule = { fg = colors.orange },
            BlinkCmpKindNamespace = { fg = colors.red },
            BlinkCmpKindNull = { fg = colors.gray },
            BlinkCmpKindNumber = { fg = colors.orange },
            BlinkCmpKindObject = { fg = colors.red },
            BlinkCmpKindOperator = { fg = colors.red },
            BlinkCmpKindPackage = { fg = colors.yellow },
            BlinkCmpKindProperty = { fg = colors.cyan },
            BlinkCmpKindReference = { fg = colors.orange },
            BlinkCmpKindSnippet = { fg = colors.green },
            BlinkCmpKindString = { fg = colors.green },
            BlinkCmpKindStruct = { fg = colors.purple },
            BlinkCmpKindText = { fg = colors.green },
            BlinkCmpKindTypeParameter = { fg = colors.red },
            BlinkCmpKindUnit = { fg = colors.green },
            BlinkCmpKindValue = { fg = colors.orange },
            BlinkCmpKindVariable = { fg = colors.purple },
            BlinkCmpKindCodeium = { fg = colors.green },
            BlinkCmpKindCopilot = { fg = colors.cyan },
            BlinkCmpKind = { fg = colors.blue },
        }
        for group, hl in pairs(blink_cmp_hls) do
            opts.highlights[group] = hl
        end
        local helpers = require("onedarkpro.helpers")
        opts.highlights["CursorColumn"] = { bg = helpers.lighten(colors.bg, 10) }
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
