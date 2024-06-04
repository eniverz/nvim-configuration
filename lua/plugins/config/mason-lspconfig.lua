return function(_, opts)
    local diagnostics_virtual_text = require("config.lsp").diagnostics_virtual_text
    local diagnostics_level = require("config.lsp").diagnostics_level

    local nvim_lsp = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    require("lspconfig.ui.windows").default_options.border = "rounded"

    require("mason-lspconfig").setup(opts)

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        signs = true,
        underline = true,
        virtual_text = diagnostics_virtual_text and {
            severity_limit = diagnostics_level,
        } or false,
        -- set update_in_insert to false bacause it was enabled by lspsaga
        update_in_insert = false,
    })

    local lsp_opts = {
        capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = require("keymap.completion").lsp,
    }
    ---A handler to setup all servers defined under `completion/servers/*.lua`
    ---@param lsp_name string
    local function mason_lsp_handler(lsp_name)
        -- rust_analyzer is configured using mrcjkb/rustaceanvim
        -- warn users if they have set it up manually
        if lsp_name == "rust_analyzer" then
            local config_exist = pcall(require, "plugins.config.servers." .. lsp_name)
            if config_exist then
                vim.notify(
                    [[
`rust_analyzer` is configured independently via `mrcjkb/rustaceanvim`. To get rid of this warning,
please REMOVE your LSP configuration (rust_analyzer.lua) from the `servers` directory and configure
`rust_analyzer` using the appropriate init options provided by `rustaceanvim` instead.]],
                    vim.log.levels.WARN,
                    { title = "nvim-lspconfig" }
                )
            end
            return
        end

        local ok, custom_handler = pcall(require, "plugins.config.servers." .. lsp_name)
        -- print("plugins.config.servers." .. lsp_name .. " ok: " .. (ok and "true" or "false"))
        if lsp_name == "lua_ls" then
            pcall(require, "neodev")
        end
        -- if lsp_name == "lua_ls" and type(custom_handler) == "table" then
        --     print(lsp_name)
        --     for i, p in ipairs(custom_handler.settings.Lua.diagnostics.globals) do
        --         print(p)
        --     end
        -- end
        if not ok then
            -- Default to use factory config for server(s) that doesn't include a spec
            nvim_lsp[lsp_name].setup(lsp_opts)
            return
        elseif type(custom_handler) == "function" then
            --- Case where language server requires its own setup
            --- Make sure to call require("lspconfig")[lsp_name].setup() in the function
            --- See `clangd.lua` for example.
            custom_handler(lsp_opts)
        elseif type(custom_handler) == "table" then
            nvim_lsp[lsp_name].setup(vim.tbl_deep_extend("force", lsp_opts, custom_handler))
        else
            vim.notify(
                string.format(
                    "Failed to setup [%s].\n\nServer definition under `completion/servers` must return\neither a fun(opts) or a table (got '%s' instead)",
                    lsp_name,
                    type(custom_handler)
                ),
                vim.log.levels.ERROR,
                { title = "nvim-lspconfig" }
            )
        end
    end

    mason_lspconfig.setup_handlers({ mason_lsp_handler })
end
