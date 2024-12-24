return {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    ---@type CatppuccinOptions
    opts = {
        integrations = {
            default_integrations = false,
            barbar = true,
            blink_cmp = true,
            diffview = true,
            fidget = true,
            gitsigns = true,
            lsp_saga = true,
            markdown = true,
            noice = true,
            rainbow_delimiters = true,
            snacks = true,
            semantic_tokens = true,
            telescope = { enabled = true, style = "nvchad" },
            treesitter = true,
            treesitter_context = true,
            which_key = true,

            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "italic" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                },
            },
        },
        term_colors = true,
        compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
        styles = {
            comments = { "italic" },
            properties = { "italic" },
            functions = { "bold" },
            keywords = { "italic" },
            operators = { "bold" },
            conditionals = { "bold" },
            loops = { "bold" },
            booleans = { "bold", "italic" },
            numbers = {},
            types = {},
            strings = {},
            variables = {},
        },
        highlight_overrides = {
            ---@param cp palette
            all = function(cp)
                local transparent_background = require("config.scheme").transparent_background
                local clear = {}

                return {
                    -- For base configs
                    NormalFloat = { fg = cp.text, bg = transparent_background and cp.none or cp.mantle },
                    FloatBorder = {
                        fg = transparent_background and cp.blue or cp.lavender,
                        bg = transparent_background and cp.none or cp.mantle,
                    },
                    CursorLineNr = { fg = cp.green },

                    -- For native lsp configs
                    DiagnosticVirtualTextError = { bg = cp.none },
                    DiagnosticVirtualTextWarn = { bg = cp.none },
                    DiagnosticVirtualTextInfo = { bg = cp.none },
                    DiagnosticVirtualTextHint = { bg = cp.none },
                    LspInfoBorder = { link = "FloatBorder" },

                    -- For mason.nvim
                    MasonNormal = { link = "NormalFloat" },

                    -- For indent-blankline
                    IblIndent = { fg = cp.surface0 },
                    IblScope = { fg = cp.surface2, style = { "bold" } },

                    -- For Git
                    NeoTreeGitAdded = { fg = cp.green },
                    NeoTreeGitStaged = { fg = cp.teal },
                    NeoTreeGitConflict = { fg = cp.maroon },
                    NeoTreeGitDeleted = { fg = cp.red },
                    NeoTreeModified = { fg = cp.peach },
                    NeoTreeGitUnstaged = { fg = cp.sky },
                    NeoTreeGitUntracked = { fg = cp.sky },
                    NeoTreeGitModified = { fg = cp.yellow },
                    NeoTreeGitModified_35 = { fg = cp.yellow },
                    NeoTreeGitModified_60 = { fg = cp.yellow },
                    NeoTreeGitModified_68 = { fg = cp.yellow },

                    -- For nvim-cmp and wilder.nvim
                    Pmenu = { fg = cp.overlay2, bg = transparent_background and cp.none or cp.base },
                    PmenuBorder = { fg = cp.surface1, bg = transparent_background and cp.none or cp.base },
                    PmenuSel = { bg = cp.green, fg = cp.base },
                    CmpItemAbbr = { fg = cp.overlay2 },
                    CmpItemAbbrMatch = { fg = cp.blue, style = { "bold" } },
                    CmpDoc = { link = "NormalFloat" },
                    CmpDocBorder = {
                        fg = transparent_background and cp.surface1 or cp.mantle,
                        bg = transparent_background and cp.none or cp.mantle,
                    },

                    -- For fidget
                    FidgetTask = { bg = cp.none, fg = cp.surface2 },
                    FidgetTitle = { fg = cp.blue, style = { "bold" } },

                    -- For nvim-notify
                    NotifyBackground = { bg = cp.base },

                    -- For trouble.nvim
                    TroubleNormal = { bg = transparent_background and cp.none or cp.base },

                    -- For telescope.nvim
                    TelescopeMatching = { fg = cp.lavender },
                    TelescopeResultsDiffAdd = { fg = cp.green },
                    TelescopeResultsDiffChange = { fg = cp.yellow },
                    TelescopeResultsDiffDelete = { fg = cp.red },
                    TelescopeBorder = {
                        fg = cp.blue,
                        bg = cp.none,
                    },
                    TelescopeNormal = {
                        bg = cp.none,
                    },
                    TelescopePromptBorder = {
                        fg = cp.blue,
                        bg = cp.none,
                    },
                    TelescopePromptNormal = {
                        fg = cp.text,
                        bg = cp.none,
                    },
                    TelescopePromptPrefix = {
                        fg = cp.flamingo,
                        bg = cp.none,
                    },
                    TelescopePreviewTitle = {
                        fg = cp.green,
                        bg = cp.none,
                    },
                    TelescopePromptTitle = {
                        fg = cp.red,
                        bg = cp.none,
                    },
                    TelescopeResultsTitle = {
                        fg = cp.lavender,
                        bg = cp.none,
                    },
                    TelescopeSelection = {
                        fg = cp.flamingo,
                        bg = cp.none,
                        style = { "bold" },
                    },
                    TelescopeSelectionCaret = { fg = cp.flamingo },

                    -- For nvim-treehopper
                    TSNodeKey = {
                        fg = cp.peach,
                        bg = transparent_background and cp.none or cp.base,
                        style = { "bold", "underline" },
                    },

                    -- For treesitter
                    ["@keyword"] = { fg = cp.red },
                    ["@keyword.return"] = { fg = cp.pink, style = clear },
                    ["@error.c"] = { fg = cp.none, style = clear },
                    ["@error.cpp"] = { fg = cp.none, style = clear },

                    -- For blink_cmp
                    BlinkCmpKindCopilot = { fg = cp.teal }
                }
            end,
        },
    },
    config = function(_, opts)
        local scheme = require("config.scheme")
        opts = vim.tbl_deep_extend("force", opts, {
            transparent_background = scheme.transparent_background,
        })
        require("catppuccin").setup(opts)
        if scheme.colorscheme:find("catppuccin") then
            vim.api.nvim_command("colorscheme " .. scheme.colorscheme)
        end
    end,
}
