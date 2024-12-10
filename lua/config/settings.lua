local settings = {
    use_ssh = false,
    notifications = true,
    gui_config = {
        font_name = "CodeNewRoman Nerd Font",
        font_size = 12,
    },
    external_browser = "google_chrome --incognito",
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
        },
    },
    sessions = {
        save_dir = "session",
    },
    ignore_files = {
        "%.git/",
        ".cache",
        "build/",
        "%.pdf",
        "%.mp3",
        "%.mkv",
        "%.mp4",
        "%.zip",
        "node_modules/.*",
        "yarn.lock",
        "package%-lock.json",
        "lazy%-lock.json",
    },
    formatter = {
        enabled = true,
        format_on_save = false,
        format_notify = true,
        format_modifications_only = true,
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
