if true then
    return {
        {
            "catppuccin/nvim",
            name = "catppuccin",
            lazy = false,
            ---@type CatppuccinOptions
            opts = {
                integrations = {
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
                    mini = false,
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
                                fg = transparent_background and cp.blue or cp.mantle,
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

                            -- For nvim-tree
                            NvimTreeRootFolder = { fg = cp.pink },
                            NvimTreeIndentMarker = { fg = cp.surface2 },

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

                            -- For glance.nvim
                            GlanceWinBarFilename = { fg = cp.subtext1, style = { "bold" } },
                            GlanceWinBarFilepath = { fg = cp.subtext0, style = { "italic" } },
                            GlanceWinBarTitle = { fg = cp.teal, style = { "bold" } },
                            GlanceListCount = { fg = cp.lavender },
                            GlanceListFilepath = { link = "Comment" },
                            GlanceListFilename = { fg = cp.blue },
                            GlanceListMatch = { fg = cp.lavender, style = { "bold" } },
                            GlanceFoldIcon = { fg = cp.green },

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
                        }
                    end,
                },
            },
            config = function(_, opts)
                local transparent_background = require("config.scheme").transparent_background
                opts = require("utils.core").extend_tbl(opts, {
                    transparent_background = transparent_background,
                })
                require("catppuccin").setup(opts)
            end,
        },
        {
            "akinsho/bufferline.nvim",
            optional = true,
            opts = function(_, opts)
                return require("utils.core").extend_tbl(opts, {
                    highlights = require("catppuccin.groups.integrations.bufferline").get(),
                })
            end,
        },
        {
            "nvim-telescope/telescope.nvim",
            optional = true,
            opts = {
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            },
        },
    }
end

-- integrations
--     leap = false,
--     lightspeed = false,
--     mini = false,
--     navic = { enabled = false },
--     neogit = false,
--     neotest = false,
--     overseer = false,
--     pounce = false,
--     sandwich = false,
--     telekasten = false,
--     vim_sneak = false,
--     vimwiki = false,
