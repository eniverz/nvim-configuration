return {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    init_options = {
        provideFormatter = true,
    },
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enabled = true },
        },
    },
    root_markers = { ".git" },
}
