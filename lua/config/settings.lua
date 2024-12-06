local settings = {
    use_ssh = false,
    notifications = true,
    autopairs = true,
    gui_config = {
        font_name = "CodeNewRoman Nerd Font",
        font_size = 12,
    },
    large_buf = {
        size = 1024 * 1024 * 1.5,
        features = {
            "cmp",
            "indent_blankline",
            "illuminate",
            "lsp",
            "matchparen",
            "syntax",
            "treesitter",
            "vimopts",
        }
    },
    sessions = {
        save_dir = "session",
    },
    external_browser = "xdg-open",
    formatter = {
        format_on_save = true,
        format_notify = true,
        format_modifications_only = false,
        format_disabled_dirs = {},
        formatter_block_list = {
            lua = false, -- example
        },
        server_formatting_block_list = {
            lua_ls = true,
            tsserver = true,
            clangd = true,
        },
        disabled = false,
        codelens = true,
        inlay_hints = false,
        semantic_tokens = true,
    },
    lsp = {
        features = {
            autopairs = true,
            copilot = true,
        },
        diagnostics_virtual_text = true,
        diagnostics_level = "Hint",
    },
}

return settings
