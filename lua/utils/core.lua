local M = {}

function M.on_load(plugins, load_op)
    local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
    if lazy_config_avail then
        if type(plugins) == "string" then plugins = { plugins } end
        if type(load_op) ~= "function" then
            local to_load = type(load_op) == "string" and { load_op } or load_op --[=[@as string[]]=]
            load_op = function() require("lazy").load { plugins = to_load } end
        end

        for _, plugin in ipairs(plugins) do
            if vim.tbl_get(lazy_config.plugins, plugin, "_", "loaded") then
                vim.schedule(load_op)
                return
            end
        end
        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyLoad",
            desc = ("A function to be ran when one of these plugins runs: %s"):format(vim.inspect(plugins)),
            callback = function(args)
                if vim.tbl_contains(plugins, args.data) then
                    load_op()
                    return true
                end
            end,
        })
    end
end

--- A helper function to wrap a module function to require a plugin before running
---@param plugin string The plugin to call `require("lazy").load` with
---@param module table The system module where the functions live (e.g. `vim.ui`)
---@param funcs string|string[] The functions to wrap in the given module (e.g. `"ui", "select"`)
function M.load_plugin_with_func(plugin, module, funcs)
    if type(funcs) == "string" then funcs = { funcs } end
    for _, func in ipairs(funcs) do
        local old_func = module[func]
        module[func] = function(...)
            module[func] = old_func
            require("lazy").load { plugins = { plugin } }
            module[func](...)
        end
    end
end

--- Get a plugin spec from lazy
---@param plugin string The plugin to search for
---@return LazyPlugin? available # The found plugin spec from Lazy
function M.get_plugin(plugin)
    local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
    return lazy_config_avail and lazy_config.spec.plugins[plugin] or nil
end

--- Check if a plugin is defined in lazy. Useful with lazy loading when a plugin is not necessarily loaded yet
---@param plugin string The plugin to search for
---@return boolean available # Whether the plugin is available
function M.is_available(plugin) return M.get_plugin(plugin) ~= nil end

--- Resolve the options table for a given plugin with lazy
---@param plugin string The plugin to search for
---@return table opts # The plugin options
function M.plugin_opts(plugin)
    local spec = M.get_plugin(plugin)
    return spec and require("lazy.core.plugin").values(spec, "opts") or {}
end

--- Merge extended options with a default table of options
---@param default? table The default table that you want to merge into
---@param opts? table The new options that should be merged with the default table
---@return table # The merged table
function M.extend_tbl(default, opts)
    opts = opts or {}
    return default and vim.tbl_deep_extend("force", default, opts) or opts
end

--- Check if a buffer is valid
---@param bufnr integer? The buffer to check, default to current buffer
---@return boolean # Whether the buffer is valid or not
function M.is_valid(bufnr)
    if not bufnr then bufnr = 0 end
    return vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted
end

return M
