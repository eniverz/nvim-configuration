local global = require("config.global")

local clone_prefix = global.use_ssh and "git@github.com:%s.git" or "https://github.com/%s.git"
local lazy_settings = {
    root = global.data_dir .. "lazy", -- directory where plugins will be installed
    git = {
        -- log = { "-10" }, -- show the last 10 commits
        timeout = 300,
        url_format = clone_prefix,
    },
    install = {
        -- install missing plugins on startup. This doesn't increase startup time.
        missing = true,
        colorscheme = { global.colorscheme },
    },
    ui = {
        -- a number <1 is a percentage., >1 is a fixed size
        size = { width = 0.88, height = 0.8 },
        wrap = true, -- wrap the lines in the ui
        -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
        border = "rounded",
        icons = {
            cmd = " ",
            config = "",
            event = " ",
            ft = " ",
            init = " ",
            import = " ",
            keys = " ",
            lazy = "󰒲 ",
            loaded = "●",
            not_loaded = "○",
            plugin = " ",
            runtime = " ",
            require = "󰢱 ",
            source = " ",
            start = " ",
            task = "✔ ",
            list = {
                "●",
                "➜",
                "★",
                "‒",
            },
        },
    },
    performance = {
        cache = {
            enabled = true,
            path = vim.fn.stdpath("cache") .. "/lazy/cache",
            -- Once one of the following events triggers, caching will be disabled.
            -- To cache all modules, set this to `{}`, but that is not recommended.
            disable_events = { "UIEnter", "BufReadPre" },
            ttl = 3600 * 24 * 2, -- keep unused modules for up to 2 days
        },
        reset_packpath = true, -- reset the package path to improve startup time
        rtp = {
            reset = true, -- reset the runtime path to $VIMRUNTIME and the config directory
            ---@type string[]
            paths = {}, -- add any custom paths here that you want to include in the rtp
        },
    },
    readme = {
        enabled = true,
        root = vim.fn.stdpath("state") .. "/lazy/readme",
        files = { "README.*", "lua/**/README.*" },
        -- only generate markdown helptags for plugins that dont have docs
        skip_if_doc_exists = true,
    },
    dev = {
        path = "~/Documents/neovim",
    }
}
if global.is_mac then
    lazy_settings.concurrency = 20
end
-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
    -- stylua: ignore
    local lazy_repo = global.use_ssh and "git@github.com:folke/lazy.nvim.git " or "https://github.com/folke/lazy.nvim.git "
    vim.api.nvim_command("!git clone --filter=blob:none --branch=stable " .. lazy_repo .. lazypath)
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
    -- stylua: ignore
    vim.api.nvim_echo(
        { { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } },
        true, {})
    vim.fn.getchar()
    vim.cmd.quit()
end

require("lazy").setup({
    { import = "themes" },
    -- { import = "plugins.dap" },
    { import = "plugins.editor" },
    { import = "plugins.formatter" },
    { import = "plugins.languages" },
    { import = "plugins.lsp" },
}, lazy_settings)
