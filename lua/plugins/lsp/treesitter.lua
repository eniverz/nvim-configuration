-- syntax highlighting
return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = true,
        dependencies = { { "nvim-treesitter/nvim-treesitter-textobjects", lazy = true } },
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
        build = ":TSUpdate",
        init = function(plugin)
            -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
            -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
            -- no longer trigger the **nvim-treeitter** module to be loaded in time.
            -- Luckily, the only thins that those plugins need are the custom queries, which we make available
            -- during startup.
            -- CODE FROM LazyVim (thanks folke!) https://github.com/LazyVim/LazyVim/commit/1e1b68d633d4bd4faa912ba5f49ab6b8601dc0c9
            require("lazy.core.loader").add_to_rtp(plugin)
            require "nvim-treesitter.query_predicates"
        end,
        config = vim.schedule_wrap(function(_, opts)
            local use_ssh = require("config.settings").use_ssh

            vim.api.nvim_set_option_value("foldmethod", "expr", {})
            vim.api.nvim_set_option_value("foldexpr", "nvim_treesitter#foldexpr()", {})

            require("nvim-treesitter.configs").setup({
                ensure_installed = opts.ensure_installed or "maintained",
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
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]["] = "@function.outer",
                            ["]m"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]]"] = "@function.outer",
                            ["]M"] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[["] = "@function.outer",
                            ["[m"] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[]"] = "@function.outer",
                            ["[M"] = "@class.outer",
                        },
                    },
                },
                indent = { enable = true },
                matchup = { enable = true },
            })
            require("nvim-treesitter.install").prefer_git = true
            if use_ssh then
                local parsers = require("nvim-treesitter.parsers").get_parser_configs()
                for _, p in pairs(parsers) do
                    p.install_info.url = p.install_info.url:gsub("https://github.com/", "git@github.com:")
                end
            end
        end),
    },
    { "andymass/vim-matchup" },
    { "mfussenegger/nvim-treehopper" },
    {
        "abecodes/tabout.nvim",
        event  = "InsertEnter",
        opts = {
            tabkey = "",        -- key to trigger tabout, set to an empty string to disable
            backwards_tabkey = "", -- key to trigger backwards tabout, set to an empty string to disable
            act_as_tab = true,  -- shift content if tab out is not possible
            act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
            enable_backwards = true,
            completion = true,  -- if the tabkey is used in a completion pum
            tabouts = {
                { open = "'", close = "'" },
                { open = '"', close = '"' },
                { open = "`", close = "`" },
                { open = "(", close = ")" },
                { open = "[", close = "]" },
                { open = "{", close = "}" },
            },
            ignore_beginning = true, -- if the cursor is at the beginning of a filled element it will rather tab out than shift the content
            exclude = {},      -- tabout will ignore these filetypes
        },
        config = function (_, opts)
            require("tabout").setup(opts)
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        opts = {
            filetypes = {
                "html",
                "javascript",
                "javascriptreact",
                "typescriptreact",
                "vue",
                "xml",
            },
        },
        config = require("plugins.config.ts-autotag"),
    },
    {
        "NvChad/nvim-colorizer.lua",
        cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
        opts = { user_default_options = { names = false } },
        config = function(_, opts)
            local colorizer = require "colorizer"
            colorizer.setup(opts)
            for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
                if vim.t[tab].bufs then vim.tbl_map(function(buf) colorizer.attach_to_buffer(buf) end, vim.t[tab].bufs) end
            end
        end,
    },
    {
        "hiphish/rainbow-delimiters.nvim",
        config = function()
            ---@param threshold number @Use global strategy if nr of lines exceeds this value
            local function init_strategy(threshold)
                return function()
                    local errors = 200
                    vim.treesitter.get_parser():for_each_tree(function(lt)
                        if lt:root():has_error() and errors >= 0 then
                            errors = errors - 1
                        end
                    end)
                    if errors < 0 then
                        return nil
                    end
                    return vim.fn.line("$") > threshold and require("rainbow-delimiters").strategy["global"]
                    or require("rainbow-delimiters").strategy["local"]
                end
            end

            vim.g.rainbow_delimiters = {
                strategy = {
                    [""] = init_strategy(500),
                    c = init_strategy(200),
                    cpp = init_strategy(200),
                    lua = init_strategy(500),
                    vimdoc = init_strategy(300),
                    vim = init_strategy(300),
                },
                query = {
                    [""] = "rainbow-delimiters",
                    latex = "rainbow-blocks",
                    javascript = "rainbow-delimiters-react",
                },
                highlight = {
                    "RainbowDelimiterRed",
                    "RainbowDelimiterOrange",
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterCyan",
                    "RainbowDelimiterViolet",
                },
            }
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts ={
            enable = true,
            max_lines = 3,      -- How many lines the window should span. Values <= 0 mean no limit.
            min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
            line_numbers = true,
            multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
            trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
            mode = "cursor",    -- Line used to calculate context. Choices: 'cursor', 'topline'
            zindex = 30,
        },
        config = function()
            require("treesitter-context").setup()
        end,
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        init = function()
            if vim.fn.has "nvim-0.10" == 1 then
                -- HACK: add workaround for native comments: https://github.com/JoosepAlviste/nvim-ts-context-commentstring/issues/109
                vim.schedule(function()
                    local get_option = vim.filetype.get_option
                    local context_commentstring
                    vim.filetype.get_option = function(filetype, option)
                        if option ~= "commentstring" then return get_option(filetype, option) end
                        if context_commentstring == nil then
                            local ts_context_avail, ts_context = pcall(require, "ts_context_commentstring.internal")
                            context_commentstring = ts_context_avail and ts_context
                        end
                        return context_commentstring and context_commentstring.calculate_commentstring()
                        or get_option(filetype, option)
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
}
