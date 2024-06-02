local lazy_config = require("config.lazy")

-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
    -- stylua: ignore
    local lazy_repo = require("config.settings").use_ssh and "git@github.com:folke/lazy.nvim.git " or "https://github.com/folke/lazy.nvim.git "
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
    { import = "plugins.editor" },
    { import = "plugins.formatter" },
    { import = "plugins.languages" },
    { import = "plugins.lsp" },
    { import = "plugins.tools" },
    { import = "plugins" },
    { import = "themes" },
}, lazy_config)
