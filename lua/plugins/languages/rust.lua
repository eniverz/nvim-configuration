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
        "jay-babu/mason-nvim-dap.nvim",
        optional = true,
        opts = function(_, opts)
            opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "codelldb" })
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = function(_, opts)
            opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "codelldb" })
        end,
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^4",
        ft = "rust",
        opts = function()
            local adapter
            local success, package = pcall(function() return require("mason-registry").get_package "codelldb" end)
            local cfg = require "rustaceanvim.config"
            if success then
                local package_path = package:get_install_path()
                local codelldb_path = package_path .. "/codelldb"
                local liblldb_path = package_path .. "/extension/lldb/lib/liblldb"
                local this_os = vim.loop.os_uname().sysname

                -- The path in windows is different
                if this_os:find "Windows" then
                    codelldb_path = package_path .. "\\extension\\adapter\\codelldb.exe"
                    liblldb_path = package_path .. "\\extension\\lldb\\bin\\liblldb.dll"
                else
                    -- The liblldb extension is .so for linux and .dylib for macOS
                    liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
                end
                adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
            else
                adapter = cfg.get_codelldb_adapter()
            end

            local lsp_opts = {
                capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
                on_attach = require("keymap.completion"),
                settings = {
                    ["rust-analyzer"] = {
                        check = {
                            command = "clippy",
                            extraArgs = {
                                "--no-deps",
                            },
                        },
                        assist = {
                            importEnforceGranularity = true,
                            importPrefix = "crate",
                        },
                        completion = {
                            postfix = {
                                enable = false,
                            },
                        },
                        inlayHints = {
                            lifetimeElisionHints = {
                                enable = true,
                                useParameterNames = true,
                            },
                        },
                    }
                },
                -- Disable automatic DAP configuration to avoid conflicts with previous user configs
                dap = {
                    adapter = false,
                    configuration = false,
                    autoload_configurations = false,
                },
            }
            local server = {
                ---@type table | (fun(project_root:string|nil, default_settings: table|nil):table) -- The rust-analyzer settings or a function that creates them.
                settings = function(project_root, default_settings)
                    local lsp_settings = lsp_opts.settings or {}

                    local merge_table = require("utils.core").extend_tbl(default_settings or {}, lsp_settings)
                    local ra = require "rustaceanvim.config.server"
                    -- load_rust_analyzer_settings merges any found settings with the passed in default settings table and then returns that table
                    return ra.load_rust_analyzer_settings(project_root, {
                        settings_file_pattern = "rust-analyzer.json",
                        default_settings = merge_table,
                    })
                end,
            }
            local final_server = require("utils.core").extend_tbl(lsp_opts, server)
            return { server = final_server, dap = { adapter = adapter }, tools = { enable_clippy = false } }
        end,
        config = function(_, opts) vim.g.rustaceanvim = require("utils.core").extend_tbl(opts, vim.g.rustaceanvim) end,
    },
    {
        "Saecki/crates.nvim",
        lazy = true,
        event = "BufReadPost Cargo.toml",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            src = {
                cmp = { enabled = true },
            },
            null_ls = {
                enabled = true,
                name = "crates.nvim",
            },
        },
        config = require("plugins.config.crates"),
    },
}
