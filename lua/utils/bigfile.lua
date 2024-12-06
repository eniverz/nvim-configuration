local M = {}

---disable auto completion
function M.cmp()
    pcall(function()
        require("cmp").setup.buffer({ enabled = false })
    end)
end

---disable indent blankline
function M.indent_blankline()
    pcall(function()
        require("indent_blankline.commands").disable()
    end)
end

---disable illuminate
---@param ctx {buf: number, ft: string}
function M.illuminate(ctx)
    pcall(function()
        require("illuminate.engine").stop_buf(ctx.buf)
    end)
end

---disable lsp
---@param ctx {buf: number, ft: string}
function M.lsp(ctx)
    vim.api.nvim_create_autocmd({ "LspAttach" }, {
        buffer = ctx.buf,
        callback = function(args)
            vim.schedule(function()
                vim.lsp.buf_detach_client(ctx.buf, args.data.client_id)
            end)
        end,
    })
end

---disable matchparen
function M.matchparen()
    if vim.fn.exists(":DoMatchParen") ~= 2 then
        return
    end
    vim.cmd([[NoMatchParen]])
end

---disable syntax highlighting
---@param ctx {buf: number, ft:string}
function M.syntax(ctx)
    vim.schedule(function()
        vim.bo[ctx.buf].syntax = ctx.ft
    end)
end

local is_ts_configured = false
local function configure_treesitter()
    local status_ok, ts_config = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
        return
    end

    local disable_cb = function(_, buf)
        local success, detected = pcall(vim.api.nvim_buf_get_var, buf, "bigfile_disable_treesitter")
        return success and detected
    end

    for _, mod_name in ipairs(ts_config.available_modules()) do
        local module_config = ts_config.get_module(mod_name) or {}
        local old_disabled = module_config.disable
        module_config.disable = function(lang, buf)
            return disable_cb(lang, buf)
                or (type(old_disabled) == "table" and vim.tbl_contains(old_disabled, lang))
                or (type(old_disabled) == "function" and old_disabled(lang, buf))
        end
    end

    is_ts_configured = true
end

---disable treesitter
---@param ctx {buf: number, ft:string}
function M.treesitter(ctx)
    if not is_ts_configured then
        configure_treesitter()
    end
    vim.api.nvim_buf_set_var(ctx.buf, "bigfile_disable_treesitter", true)
end

---disable vim options
function M.vimopts()
    vim.opt_local.swapfile = false
    vim.opt_local.foldmethod = "manual"
    vim.opt_local.undolevels = -1
    vim.opt_local.undoreload = 0
    vim.opt_local.list = false
end

return M
