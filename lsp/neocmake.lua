return {
    cmd = { "neocmakelsp", "--stdio" },
    filetypes = { "cmake" },
    root_markers = { ".git", "build", "cmake" },
    capabilities = { textDocument = { completion = { completionItem = { snippetSupport = true } } } },
    init_options = { buildDirectory = "cmake-build-debug" },
}
