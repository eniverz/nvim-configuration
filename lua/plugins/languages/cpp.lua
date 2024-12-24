local uname = (vim.uv or vim.loop).os_uname()
local is_linux_arm = uname.sysname == "Linux" and (uname.machine == "aarch64" or vim.startswith(uname.machine, "arm"))

return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "cpp", "c", "cuda" })
            end
        end,
    },
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
        "neovim/nvim-lspconfig",
        optional = true,
        opts = { server = { clangd = {} } },
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
                        return {
                            "-style=file:" .. vim.fn.stdpath("config") .. "/lua/config/format/.clang-format",
                        }
                    end,
                    args = { "-assume-filename", "$FILENAME" },
                    range_args = function(_, ctx)
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
                },
            },
        },
    },
    {
        "Shatur/neovim-tasks",
        optional = true,
        opts = function()
            local path = require("plenary.path")
            return {
                default_params = {
                    cmake = {
                        cmd = "cmake",
                        build_dir = function()
                            print(tostring(path:new("{cwd}", "cmake-build-")) .. string.lower(tostring(path:new("{build_type}"))))
                            return tostring(path:new("{cwd}", "cmake-build-")) .. string.lower(tostring(path:new("{build_type}")))
                        end,
                        build_type = "Debug",
                        dap_name = "codelldb",
                        args = {
                            configure = {
                                "-D",
                                "CMAKE_MAKE_PROGRAM=ninja",
                                "-D",
                                "CMAKE_C_COMPILER=gcc",
                                "-G",
                                "Ninja",
                                "-S",
                                "./",
                                "-B",
                                tostring(path:new("{cwd}", "cmake-build-")) .. string.lower(tostring(path:new("{build_type}"))),
                            },
                            build = {
                                "--build",
                                tostring(path:new("{cwd}", "cmake-build-")) .. string.lower(tostring(path:new("{build_type}"))),
                                "-j18",
                            },
                        },
                        save_before_run = true,
                        params_file = "neovim.json",
                        quickfix = {
                            pos = "botright", -- Default quickfix position.
                            height = 12, -- Default height.
                        },
                        dap_open_command = function()
                            return require("dap").repl.open()
                        end,
                    },
                },
            }
        end,
    },
}
