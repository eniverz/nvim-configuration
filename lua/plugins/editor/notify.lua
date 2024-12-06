-- better notifications for neovim
return {
    {
        "rcarriga/nvim-notify",
        lazy = true,
        dependencies = { { "nvim-lua/plenary.nvim", lazy = true } },
        init = function()
            local old_func = vim["notify"]
            vim["notify"] = function(...)
                vim["notify"] = old_func
                require("lazy").load({ plugins = { "nvim-notify" } })
                vim["notify"](...)
            end
        end,
        opts = function(_, opts)
            local icons = {
                dap = require("config.icons").get("dap"),
                diagnostic = require("config.icons").get("diagnostics"),
            }
            opts.icons = {
                DEBUG = icons.dap.Debugger,
                ERROR = icons.diagnostic.Error,
                INFO = icons.diagnostic.Information,
                TRACE = icons.diagnostic.Hint,
                WARN = icons.diagnostic.Warning,
            }
            opts.max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end
            opts.max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end
            opts.on_open = function(win)
                vim.api.nvim_win_set_config(win, { zindex = 175 })
                if not require("config.settings").notifications then
                    vim.api.nvim_win_close(win, true)
                    return
                end
                pcall(function()
                    require("lazy").load({ plugins = { "nvim-treesitter" } })
                end)
                vim.wo[win].conceallevel = 3
                local buf = vim.api.nvim_win_get_buf(win)
                if not pcall(vim.treesitter.start, buf, "markdown") then
                    vim.bo[buf].syntax = "markdown"
                end
                vim.wo[win].spell = false
            end
            opts.render = "compact"
        end,
        config = function(_, opts)
            local notify = require("notify")
            notify.setup(opts)
            vim.notify = notify
        end,
    },
    {
        "catppuccin",
        optional = true,
        ---@type CatppuccinOptions
        opts = { integrations = { notify = true } },
    },
}
