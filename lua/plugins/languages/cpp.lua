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
    {
        "Civitasv/cmake-tools.nvim",
        lazy = true,
        ft = { "cmake", "make", "c", "cpp" },
        opts = {
            cmake_command = "cmake",
            ctest_command = "ctest",
            cmake_use_preset = true,
            cmake_regenerate_on_save = true,
            cmake_generate_options = {
                "-DCMAKE_BUILD_TYPE=Debug",
                "-DCMAKE_MAKE_PROGRAM=ninja",
                "-DCMAKE_C_COMPILER=gcc",
                "-G Ninja",
                "-S ./",
                "-B ./cmake-build-debug",
            }, -- this will be passed when invoke `CMakeGenerate`
            cmake_build_options = { "--build cmake-build-debug", "-j18" }, -- this will be passed when invoke `CMakeBuild`
            cmake_build_directory = function()
                if require("cmake-tools.osys").iswin32 then
                    return "cmake-build-debug"
                end
                return "cmake-build-debug"
            end,
            cmake_dap_configuration = { -- debug settings for cmake
                name = "cmake",
                type = "codelldb",
                request = "launch",
                stopOnEntry = false,
                runInTerminal = true,
                console = "integratedTerminal",
            },
        },
        config = function(_, opts)
            require("cmake-tools").setup(opts)
        end,
    },
}
