return function()
    local null_ls = require("null-ls")
    local btns = null_ls.builtins

    ---Return formatter args required by `extra_args`
    ---@param formatter_name string
    ---@return table|nil
    local function formatter_args(formatter_name)
        return require("plugins.config.formatters." .. formatter_name)
    end

    -- Please set additional flags for the supported servers here
    -- Don't specify any config here if you are using the default one.
    local sources = {
        btns.formatting.clang_format.with({
            filetypes = { "c", "cpp" },
            extra_args = formatter_args("clang_format"),
        }),
        btns.formatting.prettier.with({
            filetypes = {
                "vue",
                "typescript",
                "javascript",
                "typescriptreact",
                "javascriptreact",
                "yaml",
                "html",
                "css",
                "scss",
                "sh",
                "markdown",
            },
        }),
        btns.formatting.stylua.with({
            filetypes = { "lua", "luau" },
            extra_args = { "--config-path", vim.fn.expand("~/.config/nvim/stylua.toml") },
        }),
        btns.formatting.shfmt.with({
            filetypes = { "bash", "zsh", "sh" }
        }),

        btns.formatting.black.with({ "python" }),
        btns.formatting.isort.with({ "python" }),

        btns.diagnostics.selene.with({
            filetypes = { "lua", "luau" }
        })
    }
    require("null-ls").setup({
        border = "rounded",
        debug = false,
        log_level = "warn",
        update_in_insert = false,
        sources = sources,
    })

    require("mason-null-ls").setup({
        ensure_installed = require("config.lsp").null_ls_deps,
        automatic_installation = false,
        automatic_setup = true,
        handlers = {},
    })

    -- Setup usercmd to register/deregister available source(s)
    local function _gen_completion()
        local sources_cont = null_ls.get_source({
            filetype = vim.api.nvim_get_option_value("filetype", { scope = "local" }),
        })
        local completion_items = {}
        for _, server in pairs(sources_cont) do
            table.insert(completion_items, server.name)
        end
        return completion_items
    end
    vim.api.nvim_create_user_command("NullLsToggle", function(opts)
        if vim.tbl_contains(_gen_completion(), opts.args) then
            null_ls.toggle({ name = opts.args })
        else
            vim.notify(
                string.format("[Null-ls] Unable to find any registered source named [%s].", opts.args),
                vim.log.levels.ERROR,
                { title = "Null-ls Internal Error" }
            )
        end
    end, {
        nargs = 1,
        complete = _gen_completion,
    })

    require("utils.formatting").configure_format_on_save()
end
