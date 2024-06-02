local config = {
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
}

return config
