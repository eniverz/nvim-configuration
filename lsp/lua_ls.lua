return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim", "require", "Snacks" },
                disable = { "different-requires" },
            },
            workspace = {
                library = { vim.fn.expand("$VIMRUNTIME/lua"), vim.fn.stdpath("config") .. "/lua" },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
            hint = { enable = true, arrayIndex = "Disable" },
            format = { enable = false },
            telemetry = { enable = false },
            -- Do not override treesitter lua highlighting with lua_ls's highlighting
            semantic = { enable = false },
        },
    },
}
