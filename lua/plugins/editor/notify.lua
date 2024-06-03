-- better notifications for neovim
return {
    "rcarriga/nvim-notify",
    lazy = true,
    dependencies = { { "nvim-lua/plenary.nvim", lazy = true } },
    init = function()
        require("utils.core").load_plugin_with_func("nvim-notify", vim, "notify")
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
            local core = require("utils.core")
            vim.api.nvim_win_set_config(win, { zindex = 175 })
            if not require("config.settings").notifications then
                vim.api.nvim_win_close(win, true)
                return
            end
            if core.is_available("nvim-treesitter") then
                require("lazy").load({ plugins = { "nvim-treesitter" } })
            end
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
        require("utils.notify").setup(notify)
    end,
}
