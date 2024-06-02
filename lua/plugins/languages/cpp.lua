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
        "neovim/nvim-lspconfig",
        config = function (_, opts)
            local function switch_source_header_splitcmd(bufnr, splitcmd)
                bufnr = require("lspconfig").util.validate_bufnr(bufnr)
                local clangd_client = require("lspconfig").util.get_active_client_by_name(bufnr, "clangd")
                local params = { uri = vim.uri_from_bufnr(bufnr) }
                if clangd_client then
                    clangd_client.request("textDocument/switchSourceHeader", params, function(err, result)
                        if err then
                            error(tostring(err))
                        end
                        if not result then
                            vim.notify("Corresponding file can’t be determined", vim.log.levels.ERROR, { title = "LSP Error!" })
                            return
                        end
                        vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
                    end)
                else
                    vim.notify(
                        "Method textDocument/switchSourceHeader is not supported by any active server on this buffer",
                        vim.log.levels.ERROR,
                        { title = "LSP Error!" }
                    )
                end
            end

            local function get_binary_path_list(binaries)
                local path_list = {}
                for _, binary in ipairs(binaries) do
                    local path = vim.fn.exepath(binary)
                    if path ~= "" then
                        table.insert(path_list, path)
                    end
                end
                return table.concat(path_list, ",")
            end

            require("lspconfig").clangd.setup({
                filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
                on_attach = opts.on_attach,
                capabilities = vim.tbl_deep_extend(
                    "keep",
                    { offsetEncoding = { "utf-16", "utf-8" } },
                    opts.capabilities
                ),
                single_file_support = true,
                cmd = {
                    "clangd",
                    "-j=12",
                    "--enable-config",
                    "--background-index",
                    "--pch-storage=memory",
                    -- You MUST set this arg ↓ to your c/cpp compiler location (if not included)!
                    "--query-driver=" .. get_binary_path_list({ "clang++", "clang", "gcc", "g++" }),
                    "--clang-tidy",
                    "--all-scopes-completion",
                    "--completion-style=detailed",
                    "--header-insertion-decorators",
                    "--header-insertion=iwyu",
                    "--limit-references=3000",
                    "--limit-results=350",
                },
                commands = {
                    ClangdSwitchSourceHeader = {
                        function()
                            switch_source_header_splitcmd(0, "edit")
                        end,
                        description = "Open source/header in current buffer",
                    },
                    ClangdSwitchSourceHeaderVSplit = {
                        function()
                            switch_source_header_splitcmd(0, "vsplit")
                        end,
                        description = "Open source/header in a new vsplit",
                    },
                    ClangdSwitchSourceHeaderSplit = {
                        function()
                            switch_source_header_splitcmd(0, "split")
                        end,
                        description = "Open source/header in a new split",
                    },
                },
            })
        end
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
        "mfussenegger/nvim-dap",
        lazy = true,
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
