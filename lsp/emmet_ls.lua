return {
    cmd = { "emmet-ls", "--stdio" },
    filetypes = {
        "astro",
        "css",
        "eruby",
        "html",
        "htmlangular",
        "htmldjango",
        "javascriptreact",
        "less",
        "pug",
        "sass",
        "scss",
        "svelte",
        "templ",
        "typescriptreact",
        "vue",
    },
    root_markers = { ".git" },
    capabilities = { textDocument = { completion = { completionItem = { snippetSupport = true } } } },
    init_options = {
        html = {
            options = {
                -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                ["bem.enabled"] = true,
            },
        },
    },
}
