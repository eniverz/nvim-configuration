return {
    cmd = { "html-languageserver", "--stdio" },
    filetypes = { "html" },
    init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = { css = true, javascript = true },
        provideFormatter = false,
    },
    settings = {},
    single_file_support = true,
    flags = { debounce_text_changes = 500 },
}
