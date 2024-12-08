return {
    "nvimdev/lspsaga.nvim",
    lazy = true,
    event = "LspAttach",
    cmd = "Lspsaga",
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
    },
    opts = function()
        local icon_config = require("config.icons")
        local icons = { ui = icon_config.get("ui"), kind = icon_config.get("kind"), type = icon_config.get("type") }
        return {
            symbol_in_winbar = {
                seperator = " " .. icons.ui.Separator,
                show_file = false,
            },
            callhierarchy = { keys = { close = { "q", "<Esc>" } } },
            code_action = { keys = { quit = { "q", "<Esc>" } } },
            diagnostic = {
                max_width = 0.5,
                max_height = 0.6,
                extend_relatedInformation = true,
            },
            hover = {
                max_width = 0.45,
                max_height = 0.7,
                open_link = "gl",
                open_cmd = "!" .. require("config.settings").external_browser,
            },
            lightbulb = { enable = false },
            rename = { in_select = false },
            ui = {
                border = "rounded", -- none, single, double, shadow, rounded, solid
                expand = icons.ui.ArrowClosed,
                collapse = icons.ui.ArrowOpen,
                code_action = icons.ui.CodeAction,
                actionfix = icons.ui.Spell,
                imp_sign = icons.kind.Implementation,
                kind = {
                    -- Kind
                    Class = { icons.kind.Class, "LspKindClass" },
                    Constant = { icons.kind.Constant, "LspKindConstant" },
                    Constructor = { icons.kind.Constructor, "LspKindConstructor" },
                    Enum = { icons.kind.Enum, "LspKindEnum" },
                    EnumMember = { icons.kind.EnumMember, "LspKindEnumMember" },
                    Event = { icons.kind.Event, "LspKindEvent" },
                    Field = { icons.kind.Field, "LspKindField" },
                    File = { icons.kind.File, "LspKindFile" },
                    Function = { icons.kind.Function, "LspKindFunction" },
                    Interface = { icons.kind.Interface, "LspKindInterface" },
                    Key = { icons.kind.Keyword, "LspKindKey" },
                    Method = { icons.kind.Method, "LspKindMethod" },
                    Module = { icons.kind.Module, "LspKindModule" },
                    Namespace = { icons.kind.Namespace, "LspKindNamespace" },
                    Number = { icons.kind.Number, "LspKindNumber" },
                    Operator = { icons.kind.Operator, "LspKindOperator" },
                    Package = { icons.kind.Package, "LspKindPackage" },
                    Property = { icons.kind.Property, "LspKindProperty" },
                    Struct = { icons.kind.Struct, "LspKindStruct" },
                    TypeParameter = { icons.kind.TypeParameter, "LspKindTypeParameter" },
                    Variable = { icons.kind.Variable, "LspKindVariable" },
                    -- Type
                    Array = { icons.type.Array, "LspKindArray" },
                    Boolean = { icons.type.Boolean, "LspKindBoolean" },
                    Null = { icons.type.Null, "LspKindNull" },
                    Object = { icons.type.Object, "LspKindObject" },
                    String = { icons.type.String, "LspKindString" },
                    -- ccls-specific icons.
                    TypeAlias = { icons.kind.TypeAlias, "LspKindTypeAlias" },
                    Parameter = { icons.kind.Parameter, "LspKindParameter" },
                    StaticMethod = { icons.kind.StaticMethod, "LspKindStaticMethod" },
                    -- Microsoft-specific icons.
                    Text = { icons.kind.Text, "LspKindText" },
                    Snippet = { icons.kind.Snippet, "LspKindSnippet" },
                    Folder = { icons.kind.Folder, "LspKindFolder" },
                    Unit = { icons.kind.Unit, "LspKindUnit" },
                    Value = { icons.kind.Value, "LspKindValue" },
                },
            },
        }
    end,
    config = function(_, opts)
        local color_util = require("utils.color")
        local palettes = color_util.get_palette()
        local dat = {
            Class = palettes.yellow,
            Constant = palettes.peach,
            Constructor = palettes.sapphire,
            Enum = palettes.yellow,
            EnumMember = palettes.teal,
            Event = palettes.yellow,
            Field = palettes.teal,
            File = palettes.rosewater,
            Function = palettes.blue,
            Interface = palettes.yellow,
            Key = palettes.red,
            Method = palettes.blue,
            Module = palettes.blue,
            Namespace = palettes.blue,
            Number = palettes.peach,
            Operator = palettes.sky,
            Package = palettes.blue,
            Property = palettes.teal,
            Struct = palettes.yellow,
            TypeParameter = palettes.blue,
            Variable = palettes.peach,
            Array = palettes.peach,
            Boolean = palettes.peach,
            Null = palettes.yellow,
            Object = palettes.yellow,
            String = palettes.green,
            TypeAlias = palettes.green,
            Parameter = palettes.blue,
            StaticMethod = palettes.peach,
            Text = palettes.green,
            Snippet = palettes.mauve,
            Folder = palettes.blue,
            Unit = palettes.green,
            Value = palettes.peach,
        }
        for kind, color in pairs(dat) do
            color_util.set_global_hl("LspKind" .. kind, color)
        end

        require("lspsaga").setup(opts)
    end,
}
