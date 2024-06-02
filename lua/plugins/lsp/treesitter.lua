-- syntax highlighting
return {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    build = function()
        if #vim.api.nvim_list_uis() ~= 0 then
            vim.api.nvim_command([[TSUpdate]])
        end
    end,
    config = function()
        local config = require("nvim-treesitter.configs")
        local use_ssh = require("config.settings").use_ssh
        config.setup({
            ensure_installed = require("config.lsp").treesitter_deps,
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
            sync_install = false,
            ignore_install = {},
            auto_install = true,
            modules = {},
        })
        require("nvim-treesitter.install").prefer_git = true
        if use_ssh then
            local parsers = require("nvim-treesitter.parsers").get_parser_configs()
            for _, p in pairs(parsers) do
                p.install_info.url = p.install_info.url:gsub("https://github.com/", "git@github.com:")
            end
        end

    end,
}
