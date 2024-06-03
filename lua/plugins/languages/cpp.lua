local uname = (vim.uv or vim.loop).os_uname()
local is_linux_arm = uname.sysname == "Linux" and (uname.machine == "aarch64" or vim.startswith(uname.machine, "arm"))

return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "cpp", "c", "objc", "cuda", "proto" })
            end
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        optional = true,
        opts = function(_, opts)
            if not is_linux_arm then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "clangd" })
            end
        end,
    },
    -- {
    --     "p00f/clangd_extensions.nvim",
    --     lazy = true,
    --     opts = function()
    --         local ce = vim.api.nvim_create_augroup("clangd_extensions", { clear = true })
    --         vim.api.nvim_create_autocmd("LspAttach", {
    --             group = ce,
    --             desc = "Load clangd_extensions with clangd",
    --             callback = function(args)
    --                 if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "clangd" then
    --                     require "clangd_extensions"
    --                     vim.api.nvim_del_augroup_by_name "clangd_extensions"
    --                 end
    --             end,
    --         })

    --         local cem = vim.api.nvim_create_augroup("clangd_extension_mappings", { clear = true })
    --         vim.api.nvim_create_autocmd("LspAttach", {
    --             group = cem,
    --             desc = "Load clangd_extensions with clangd",
    --             callback = function(args)
    --                 if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "clangd" then
    --                     require("utils.core").set_mappings({
    --                         n = {
    --                             ["<Leader>lw"] = { "<Cmd>ClangdSwitchSourceHeader<CR>", desc = "Switch source/header file" },
    --                         },
    --                     }, { buffer = args.buf })
    --                 end
    --             end,
    --         })
    --     end,
    -- },
    -- {
    --     "Civitasv/cmake-tools.nvim",
    --     ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    --     dependencies = {
    --         {
    --             "jay-babu/mason-nvim-dap.nvim",
    --             opts = function(_, opts)
    --                 opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "codelldb" })
    --             end,
    --         },
    --     },
    --     opts = {},
    -- },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = function(_, opts)
            local tools = { "codelldb" }
            if not is_linux_arm then table.insert(tools, "clangd") end
            opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, tools)
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        optional = true,
        opts = function(_, opts)
            opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "codelldb", "cppdbg" })
        end,
    },
    {
        "mfussenegger/nvim-dap",
        optional = true,
        config = function ()
            local dap = require("dap")
            local utils = require("utils.dap")
            dap.configurations.c = {
                {
                    name = "Debug",
                    type = "codelldb",
                    request = "launch",
                    program = utils.input_exec_path(),
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    terminal = "integrated",
                },
                {
                    name = "CMake with CLion format",
                    type = "codelldb",
                    request = "launch",
                    program = utils.input_cmake_exec_path(),
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    terminal = "integrated",
                },
                {
                    name = "Debug (with args)",
                    type = "codelldb",
                    request = "launch",
                    program = utils.input_exec_path(),
                    args = utils.input_args(),
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    terminal = "integrated",
                },
                {
                    name = "Attach to a running process",
                    type = "codelldb",
                    request = "attach",
                    program = utils.input_exec_path(),
                    stopOnEntry = false,
                    waitFor = true,
                },
            }
            dap.configurations.cpp = dap.configurations.c
        end
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                c = { "clang-format" },
                cpp = { "clang-format" },
                objc = { "clang-format" },
                objcpp = { "clang-format" },
                cuda = { "clang-format" },
                proto = { "clang-format" },
            },
            formatters = {
                ["clang-format"] = {
                    command = "clang-format",
                    args = vim.tbl_extend("force", require("plugins.config.formatters.clang_format"), {"-assume-filename", "$FILENAME"}),
                    range_args = function(self, ctx)
                        local start_offset, end_offset = require("conform.util").get_offsets_from_range(ctx.buf, ctx.range)
                        local length = end_offset - start_offset
                        return {
                            "-assume-filename",
                            "$FILENAME",
                            "--offset",
                            tostring(start_offset),
                            "--length",
                            tostring(length),
                        }
                    end,
                }
            }
        }
    }
}
