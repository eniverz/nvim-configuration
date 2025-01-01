-- completion plugin
return {
    {
        "saghen/blink.cmp",
        lazy = true,
        event = { "InsertEnter", "LspAttach" },
        dependencies = { "giuxtaposition/blink-cmp-copilot", "rafamadriz/friendly-snippets" },
        version = "v0.*",
        opts = {
            completion = {
                trigger = {
                    show_on_blocked_trigger_characters = {},
                    show_on_x_blocked_trigger_characters = {},
                },
                list = { selection = "auto_insert" },
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
            },
            signature = { enabled = true },
            sources = {
                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-cmp-copilot",
                        score_offset = 10000,
                        transform_items = function(_, items)
                            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                            local kind_idx = #CompletionItemKind + 1
                            CompletionItemKind[kind_idx] = "Copilot"
                            for _, item in ipairs(items) do
                                item.kind = kind_idx
                                item.highlight = "BlinkCmpKindCopilot"
                            end
                            return items
                        end,
                    },
                    buffer = { score_offset = -25 },
                },
                default = { "lsp", "path", "snippets", "buffer", "copilot" },
            },
            keymap = {
                ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<ESC>"] = {
                    function(cmp)
                        local success = cmp.cancel()
                        if not success and vim.fn.mode() == "c" then
                            -- Whem in command line mode, the fallback will be "submit" event instead of "cancel". so we need to manually cancel it.
                            vim.api.nvim_input("<C-\\><C-n>")
                            success = true
                        end
                        return success
                    end,
                    "fallback",
                },
                ["<CR>"] = { "accept", "fallback" },
                ["<C-Up>"] = { "scroll_documentation_up", "fallback" },
                ["<C-Down>"] = { "scroll_documentation_down", "fallback" },
                ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<Up>"] = { "select_prev", "fallback" },
                ["<C-s>"] = { "fallback" },
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
                    Copilot = "",
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
