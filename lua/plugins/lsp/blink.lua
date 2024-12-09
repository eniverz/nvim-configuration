-- completion plugin
return {
    {
        "saghen/blink.cmp",
        lazy = true,
        event = { "InsertEnter", "LspAttach" },
        dependencies = { "giuxtaposition/blink-cmp-copilot", "rafamadriz/friendly-snippets" },
        -- build = "cargo build --release",
        version = "v0.*",
        opts = {
            sources = {
                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-cmp-copilot",
                    },
                    buffer = {
                        score_offset = -5,
                    },
                },
                completion = {
                    enabled_providers = { "lsp", "path", "snippets", "buffer", "copilot" },
                },
            },
            completion = {
                accept = {
                    auto_brackets = { enabled = true },
                },
                menu = {
                    border = "rounded",
                    scrollbar = false,
                    draw = {
                        columns = { { "item_idx" }, { "label", "label_description", gap = 1 }, { "kind_icon" } },
                        components = {
                            item_idx = {
                                text = function(ctx)
                                    return tostring(ctx.idx)
                                end,
                                highlight = "BlinkCmpItemIdx", -- optional, only if you want to change its color
                            },
                        },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 100,
                    window = { border = "single", scrollbar = false },
                },
                signature = {
                    enabled = true,
                },
            },
            keymap = {
                ["<A-1>"] = { function(cmp) cmp.accept({ index = 1 }) end, },
                ["<A-2>"] = { function(cmp) cmp.accept({ index = 2 }) end, },
                ["<A-3>"] = { function(cmp) cmp.accept({ index = 3 }) end, },
                ["<A-4>"] = { function(cmp) cmp.accept({ index = 4 }) end, },
                ["<A-5>"] = { function(cmp) cmp.accept({ index = 5 }) end, },
                ["<A-6>"] = { function(cmp) cmp.accept({ index = 6 }) end, },
                ["<A-7>"] = { function(cmp) cmp.accept({ index = 7 }) end, },
                ["<A-8>"] = { function(cmp) cmp.accept({ index = 8 }) end, },
                ["<A-9>"] = { function(cmp) cmp.accept({ index = 9 }) end, },
                ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-e>"] = { "hide", "fallback" },
                ["<ESC>"] = { "cancel", "fallback" },
                ["<CR>"] = { "select_and_accept", "fallback" },
                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },
                ["<Tab>"] = { "select_next", "fallback" },
                ["<S-Tab>"] = { "select_prev", "fallback" },
            },
            appearance = {
                kind_icons = {
                    Array = "",
                    Boolean = "󰨙",
                    Class = "",
                    Codeium = "󰘦",
                    Color = "󰏘",
                    Control = "",
                    Collapsed = "",
                    Constant = "󰏿",
                    Constructor = "",
                    Copilot = " ",
                    Enum = "󰦨",
                    EnumMember = "",
                    Event = "",
                    Field = "󰜢",
                    File = "",
                    Folder = "",
                    Function = "󰊕",
                    Interface = "󱡠",
                    Key = "",
                    Keyword = "",
                    Method = "󰊕",
                    Module = "",
                    Namespace = "󰦮",
                    Null = "",
                    Number = "󰎠",
                    Object = "",
                    Operator = "",
                    Package = "",
                    Property = "",
                    Reference = "",
                    Snippet = "",
                    String = "",
                    Struct = "󰅩",
                    TabNine = "󰏚",
                    Text = "󰉿",
                    TypeParameter = "",
                    Unit = "",
                    Value = "",
                    Variable = "",
                },
            },
        },
    },
    {
        "giuxtaposition/blink-cmp-copilot",
        lazy = true,
        dependencies = {
            "zbirenbaum/copilot.lua",
            cmd = "Copilot",
            event = "InsertEnter",
            opts = {
                panel = {
                    -- if true, it can interfere with completions in copilot-cmp
                    enabled = false,
                },
                suggestion = {
                    -- if true, it can interfere with completions in copilot-cmp
                    enabled = false,
                },
                filetypes = {
                    ["dap-repl"] = false,
                    ["big_file_disabled_ft"] = false,
                },
            },
            config = function(_, opts)
                require("copilot").setup(opts)
            end,
        },
    },
}
