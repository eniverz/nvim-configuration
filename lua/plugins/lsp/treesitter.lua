-- syntax highlighting
return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = vim.fn.argc(-1) == 0,
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        cmd = {
            "TSBufDisable",
            "TSBufEnable",
            "TSBufToggle",
            "TSDisable",
            "TSEnable",
            "TSToggle",
            "TSInstall",
            "TSInstallInfo",
            "TSInstallSync",
            "TSModuleInfo",
            "TSUninstall",
            "TSUpdate",
            "TSUpdateSync",
        },
        event = "BufReadPre",
        build = ":TSUpdate",
        init = function(plugin)
            -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
            -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
            -- no longer trigger the **nvim-treeitter** module to be loaded in time.
            -- Luckily, the only thins that those plugins need are the custom queries, which we make available
            -- during startup.
            -- CODE FROM LazyVim (thanks folke!) https://github.com/LazyVim/LazyVim/commit/1e1b68d633d4bd4faa912ba5f49ab6b8601dc0c9
            require("lazy.core.loader").add_to_rtp(plugin)
            require("nvim-treesitter.query_predicates")
        end,
        opts = {
            highlight = {
                enable = true,
                disable = function(ft, bufnr)
                    if vim.tbl_contains({ "vim" }, ft) then
                        return true
                    end

                    local ok, is_large_file = pcall(vim.api.nvim_buf_get_var, bufnr, "bigfile_disable_treesitter")
                    return ok and is_large_file
                end,
                additional_vim_regex_highlighting = false,
            },
            textobjects = {
                select = {
                    enable = true,
                    -- keymaps = {
                    --     ["af"] = "@function.outer",
                    --     ["if"] = "@function.inner",
                    --     ["ac"] = "@class.outer",
                    --     ["ic"] = "@class.inner",
                    -- },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    -- goto_next_start = {
                    --     ["]["] = "@function.outer",
                    --     ["]m"] = "@class.outer",
                    -- },
                    -- goto_next_end = {
                    --     ["]]"] = "@function.outer",
                    --     ["]M"] = "@class.outer",
                    -- },
                    -- goto_previous_start = {
                    --     ["[["] = "@function.outer",
                    --     ["[m"] = "@class.outer",
                    -- },
                    -- goto_previous_end = {
                    --     ["[]"] = "@function.outer",
                    --     ["[M"] = "@class.outer",
                    -- },
                },
            },
            indent = { enable = true },
            matchup = { enable = true },
        },
        config = vim.schedule_wrap(function(_, opts)
            local use_ssh = require("config.settings").use_ssh

            vim.api.nvim_set_option_value("foldmethod", "expr", {})
            vim.api.nvim_set_option_value("foldexpr", "nvim_treesitter#foldexpr()", {})

            opts = vim.tbl_extend("force", opts, { ensure_installed = opts.ensure_installed or "maintained" })
            require("nvim-treesitter.configs").setup(opts)
            require("nvim-treesitter.install").prefer_git = true
            if use_ssh then
                local parsers = require("nvim-treesitter.parsers").get_parser_configs()
                for _, p in pairs(parsers) do
                    p.install_info.url = p.install_info.url:gsub("https://github.com/", "git@github.com:")
                end
            end
        end),
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "VeryLazy",
        config = function()
            -- When in diff mode, we want to use the default
            -- vim text objects c & C instead of the treesitter ones.
            local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
            local configs = require("nvim-treesitter.configs")
            for name, fn in pairs(move) do
                if name:find("goto") == 1 then
                    move[name] = function(q, ...)
                        if vim.wo.diff then
                            local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
                            for key, query in pairs(config or {}) do
                                if q == query and key:find("[%]%[][cC]") then
                                    vim.cmd("normal! " .. key)
                                    return
                                end
                            end
                        end
                        return fn(q, ...)
                    end
                end
            end
        end,
    },
    { "andymass/vim-matchup", lazy = vim.fn.argc(-1) == 0, event = "BufReadPre" },
    { "mfussenegger/nvim-treehopper", lazy = vim.fn.argc(-1) == 0, event = "BufReadPre" },
    {
        "nvim-treesitter/nvim-treesitter-context",
        lazy = vim.fn.argc(-1) == 0,
        event = "BufReadPre",
        opts = {
            enable = true,
            max_lines = 2, -- How many lines the window should span. Values <= 0 mean no limit.
            min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
            line_numbers = true,
            multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
            trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
            mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
            zindex = 30,
        },
        config = function(_, opts)
            require("treesitter-context").setup(opts)
        end,
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = vim.fn.argc(-1) == 0,
        event = "BufReadPre",
        init = function()
            if vim.fn.has("nvim-0.10") == 1 then
                -- HACK: add workaround for native comments: https://github.com/JoosepAlviste/nvim-ts-context-commentstring/issues/109
                vim.schedule(function()
                    local get_option = vim.filetype.get_option
                    local context_commentstring
                    vim.filetype.get_option = function(filetype, option)
                        if option ~= "commentstring" then
                            return get_option(filetype, option)
                        end
                        if context_commentstring == nil then
                            local ts_context_avail, ts_context = pcall(require, "ts_context_commentstring.internal")
                            context_commentstring = ts_context_avail and ts_context
                        end
                        return context_commentstring and context_commentstring.calculate_commentstring() or get_option(filetype, option)
                    end
                end)
            end
        end,
        opts = { enable_autocmd = false },
        config = function(_, opts)
            vim.g.skip_ts_context_commentstring_module = true
            require("ts_context_commentstring").setup(opts)
        end,
    },
    {
        "catppuccin",
        optional = true,
        ---@type CatppuccinOptions
        opts = {
            integrations = {
                treesitter = true,
                treesitter_context = true,
                semantic_tokens = true,
                symbols_outline = false,
            },
        },
    },
}
