return {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    opts = function(_, opts)
        local new_opts = {
            group_overrides = {
                LspKindArray = { link = "@punctuation.bracket" },
                LspKindBoolean = { link = "@boolean" },
                LspKindClass = { link = "@type" },
                LspKindColor = { link = "Special" },
                LspKindConstant = { link = "@constant" },
                LspKindConstructor = { link = "@constructor" },
                LspKindEnum = { link = "@lsp.type.enum" },
                LspKindEnumMember = { link = "@lsp.type.enumMember" },
                LspKindEvent = { link = "Special" },
                LspKindField = { link = "@variable.member" },
                LspKindFile = { link = "Normal" },
                LspKindFolder = { link = "Directory" },
                LspKindFunction = { link = "@function" },
                LspKindInterface = { link = "@lsp.type.interface" },
                LspKindKey = { link = "@variable.member" },
                LspKindKeyword = { link = "@lsp.type.keyword" },
                LspKindMethod = { link = "@function.method" },
                LspKindModule = { link = "@module" },
                LspKindNamespace = { link = "@module" },
                LspKindNull = { link = "@constant.builtin" },
                LspKindNumber = { link = "@number" },
                LspKindObject = { link = "@constant" },
                LspKindOperator = { link = "@operator" },
                LspKindPackage = { link = "@module" },
                LspKindProperty = { link = "@property" },
                LspKindReference = { link = "@markup.link" },
                LspKindSnippet = { link = "Conceal" },
                LspKindString = { link = "@string" },
                LspKindStruct = { link = "@lsp.type.struct" },
                LspKindText = { link = "@markup" },
                LspKindTypeParameter = { link = "@lsp.type.typeParameter" },
                LspKindUnit = { link = "@lsp.type.struct" },
                LspKindValue = { link = "@string" },
                LspKindVariable = { link = "@variable" },
            },
        }
        local schema = require("config.scheme")
        new_opts.group_overrides = vim.tbl_extend("force", new_opts.group_overrides, schema.highlight_overrides)
        return vim.tbl_extend("force", opts, new_opts)
    end,
    config = function(_, opts)
        local scheme = require("config.scheme")
        require("vscode").setup(vim.tbl_extend("force", opts, {
            transparent = scheme.transparent_background,
        }))
        if scheme.colorscheme:find("vscode") then
            vim.api.nvim_command("colorscheme " .. scheme.colorscheme)
        end
    end,
}
