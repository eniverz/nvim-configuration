local uname = (vim.uv or vim.loop).os_uname()
local is_linux_arm = uname.sysname == "Linux" and (uname.machine == "aarch64" or vim.startswith(uname.machine, "arm"))

return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed =
                    require("utils.core").list_insert_unique(opts.ensure_installed, { "cpp", "c", "cuda" })
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
    --     ft = { "c", "cpp", "cuda" },
    --     opts = {},
    -- },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = function(_, opts)
            local tools = { "codelldb" }
            if not is_linux_arm then
                table.insert(tools, "clangd")
            end
            opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, tools)
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        optional = true,
        opts = function(_, opts)
            opts.ensure_installed =
                require("utils.core").list_insert_unique(opts.ensure_installed, { "codelldb", "cppdbg" })
        end,
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
                    prepend_args = function()
                        print(vim.fn.stdpath("config") .. "/lua/config/format/.clang-format")
                        return {
                            "-style=file:" .. vim.fn.stdpath("config") .. "/lua/config/format/.clang-format",
                        }
                    end,
                    args = { "-assume-filename", "$FILENAME" },
                    range_args = function(self, ctx)
                        local start_offset, end_offset =
                            require("conform.util").get_offsets_from_range(ctx.buf, ctx.range)
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
                },
            },
        },
    },
}
