return {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {
                    'vim',
                    'require'
                },
                disable = { "different-requires" },
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("config") .. "/lua"] = true,
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
            hint = {
                enable = true,
                arrayIndex = "Disable"
            },
            format = { enable = false },
            telemetry = { enable = false },
            -- Do not override treesitter lua highlighting with lua_ls's highlighting
            semantic = { enable = false },
        }
    }
}
