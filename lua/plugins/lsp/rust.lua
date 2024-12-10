return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "rust" })
            end
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = function(_, opts)
            opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "codelldb", "rust-analyzer" })
        end,
    },
    {
        "Saecki/crates.nvim",
        lazy = true,
        event = "BufReadPost Cargo.toml",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            thousands_separator = ",",
            completion = {
                cmp = { enabled = true },
            },
            lsp = {
                enabled = true,
                actions = true,
                completion = true,
                hover = true,
            },
        },
        config = require("plugins.config.crates"),
    },
    {
        "mrcjkb/rustaceanvim",
        lazy = true,
        ft = "rust",
        config = function()
            for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
                local default_diagnostic_handler = vim.lsp.handlers[method]
                vim.lsp.handlers[method] = function(err, result, context, config)
                    if err ~= nil and err.code == -32802 then
                        return
                    end
                    return default_diagnostic_handler(err, result, context, config)
                end
            end
            local adapter
            local success, pkg = pcall(function()
                return require("mason-registry").get_package("codelldb")
            end)
            local cfg = require("rustaceanvim.config")
            if success then
                local package_path = pkg:get_install_path()
                local codelldb_path = package_path .. "/codelldb"
                local liblldb_path = package_path .. "/extension/lldb/lib/liblldb"
                local this_os = vim.loop.os_uname().sysname

                -- The path in windows is different
                if this_os:find("Windows") then
                    codelldb_path = package_path .. "\\extension\\adapter\\codelldb.exe"
                    liblldb_path = package_path .. "\\extension\\lldb\\bin\\liblldb.dll"
                else
                    -- The liblldb extension is .so for linux and .dylib for macOS
                    liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
                end
                adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
            else
                adapter = nil
            end

            local server = {
                settings = function(project_root, default_settings)
                    local settings = vim.tbl_extend("force", default_settings or {}, {
                        ["rust-analyzer"] = {
                            check = {
                                command = "clippy",
                                extraArgs = {
                                    "--no-deps",
                                },
                            },
                        },
                    })
                    -- load_rust_analyzer_settings merges any found settings with the passed in default settings table and then returns that table
                    return require("rustaceanvim.config.server").load_rust_analyzer_settings(project_root, {
                        settings_file_pattern = "rust-analyzer.json",
                        default_settings = settings,
                    })
                end,
                capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),
                on_attach = require("keymap.completion").on_attach,
            }

            ---@type RustaceanOpts
            ---@diagnostic disable: missing-fields
            vim.g.rustaceanvim = vim.tbl_extend(
                "keep",
                vim.g.rustaceanvim or {},
                {
                    tools = {
                        enable_clippy = false,
                    },
                    dap = {
                        adapter = adapter,
                    },
                    server = server,
                }
            )
        end,
    },
}
