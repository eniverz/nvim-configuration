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
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "codelldb", "rust-analyzer" })
            end
        end,
    },
    {
        "neovim/nvim-lspconfig",
        optional = true,
        opts = {
            server = {
                rust_analyzer = {
                    settings = {
                        rust_analyzer = {
                            cargo = { allFeatures = true },
                            check = { command = "clippy", allFeatures = true },
                            diagnostics = { enable = false },
                        },
                    },
                },
            },
        },
    },
    {
        "Saecki/crates.nvim",
        lazy = true,
        event = "BufReadPost Cargo.toml",
        tag = "stable",
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
        config = function(_, opts)
            local icons = {
                diagnostics = require("config.icons").get("diagnostics", true),
                git = require("config.icons").get("git", true),
                misc = require("config.icons").get("misc", true),
                ui = require("config.icons").get("ui", true),
                kind = require("config.icons").get("kind", true),
            }

            local new_opts = {
                text = {
                    loading = " " .. icons.misc.Watch .. "Loading",
                    version = " " .. icons.ui.Check .. "%s",
                    prerelease = " " .. icons.diagnostics.Warning_alt .. "%s",
                    yanked = " " .. icons.diagnostics.Error .. "%s",
                    nomatch = " " .. icons.diagnostics.Question .. "No match",
                    upgrade = " " .. icons.diagnostics.Hint_alt .. "%s",
                    error = " " .. icons.diagnostics.Error .. "Error fetching crate",
                },
                popup = {
                    hide_on_select = true,
                    border = "rounded",
                    show_version_date = true,
                    text = {
                        title = icons.ui.Package .. "%s",
                        description = "%s",
                        created_label = icons.misc.Added .. "created" .. "        ",
                        created = "%s",
                        updated_label = icons.misc.ManUp .. "updated" .. "        ",
                        updated = "%s",
                        downloads_label = icons.ui.CloudDownload .. "downloads      ",
                        downloads = "%s",
                        homepage_label = icons.misc.Campass .. "homepage       ",
                        homepage = "%s",
                        repository_label = icons.git.Repo .. "repository     ",
                        repository = "%s",
                        documentation_label = icons.diagnostics.Information_alt .. "documentation  ",
                        documentation = "%s",
                        crates_io_label = icons.ui.Package .. "crates.io      ",
                        crates_io = "%s",
                        categories_label = icons.kind.Class .. "categories     ",
                        keywords_label = icons.kind.Keyword .. "keywords       ",
                        version = "  %s",
                        prerelease = icons.diagnostics.Warning_alt .. "%s prerelease",
                        yanked = icons.diagnostics.Error .. "%s yanked",
                        version_date = "  %s",
                        feature = "  %s",
                        enabled = icons.ui.Play .. "%s",
                        transitive = icons.ui.List .. "%s",
                        normal_dependencies_title = icons.kind.Interface .. "Dependencies",
                        build_dependencies_title = icons.misc.Gavel .. "Build dependencies",
                        dev_dependencies_title = icons.misc.Glass .. "Dev dependencies",
                        dependency = "  %s",
                        optional = icons.ui.BigUnfilledCircle .. "%s",
                        dependency_version = "  %s",
                        loading = " " .. icons.misc.Watch,
                    },
                },
                completion = {
                    text = {
                        prerelease = " " .. icons.diagnostics.Warning_alt .. "pre-release ",
                        yanked = " " .. icons.diagnostics.Error_alt .. "yanked ",
                    },
                },
            }
            opts = vim.tbl_extend("force", opts, new_opts)
            require("crates").setup(opts)

            -- Set buffer-local keymaps
            require("keymap.plugins.crates")
        end,
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                rust = { "rustfmt" },
            },
            formatters = {
                rustfmt = {
                    "--config",
                    "max_width=120,chain_width=80,fn_call_width=80,attr_fn_like_width=100,array_width=72,edition=2024,style_edition=2024",
                },
            },
        },
    },
}
