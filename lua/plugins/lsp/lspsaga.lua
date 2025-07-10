-- strong utils for lsp actions
return {
    "nvimdev/lspsaga.nvim",
    lazy = true,
    event = "LspAttach",
    cmd = "Lspsaga",
    dependencies = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
    },
    opts = function()
        local icon_config = require("config.icons")
        local icons = { ui = icon_config.get("ui"), kind = icon_config.get("kind"), type = icon_config.get("type") }
        return {
            symbol_in_winbar = { enable = false },
            callhierarchy = { keys = { close = { "q", "<Esc>" } } },
            code_action = { keys = { quit = { "q", "<Esc>" } }, extend_gitsigns = true },
            diagnostic = {
                max_width = 0.5,
                max_height = 0.6,
                extend_relatedInformation = true,
            },
            hover = {
                max_width = 0.45,
                max_height = 0.7,
                open_link = "gl",
                open_cmd = "!" .. require("config.settings").settings.external_browser,
            },
            lightbulb = { enable = false },
            outline = { win_width = 50 },
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
    keys = {
        {"<leader>lr", "<Cmd>Lspsaga rename<CR>", desc = "Lspsaga: rename in file range"},
        {"<leader>lR", "<Cmd>Lspsaga rename ++project<CR>", desc = "Lspsaga: rename in project range"},
        {"<leader>lk", "<Cmd>Lspsaga hover_doc<CR>", desc = "Lspsaga: show doc"},
        {"<leader>la", "<Cmd>Lspsaga code_action<CR>", desc = "Lspsaga: show code actions"},
        {"<leader>ld", "<Cmd>Lspsaga peek_definition<CR>", desc = "Lspsaga: show definition under cursor"},
        {"<leader>lD", "<Cmd>Lspsaga goto_definition<CR>", desc = "Lspsaga: goto definition under cursor"},
        {"<leader>ls", "<Cmd>Lspsaga outline<CR>", desc = "Lspsaga: show symbol outline"},

        {"<leader>xj", "<Cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Lspsaga: goto next diagnostic"},
        {"<leader>xk", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Lspsaga: goto previous diagnostic"},
        {"<leader>xx", "<Cmd>Lspsaga show_buf_diagnostics<CR>", desc = "Lspsaga: show diagnostics on current buffer"},
        {"<leader>xX", "<Cmd>Lspsaga show_workspace_diagnostics<CR>", desc = "Lspsaga: show diagnostics on workspace"},
    },
    config = function(_, opts)
        require("lspsaga").setup(opts)
    end,
}
