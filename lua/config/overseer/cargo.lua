local overseer = require("overseer")
local log = require("overseer.log")

---@param opts overseer.SearchParams
---@return nil|string
local function get_cargo_file(opts)
    return vim.fn.executable("cargo") and vim.fs.find("Cargo.toml", { path = opts.dir, type = "file", upward = true })[1] or nil
end

---@type overseer.TemplateFileDefinition
local template = {
    priority = 60,
    params = {
        cmd = { "cargo" },
        args = {},
        relative_file_root = {
            desc = "Relative filepaths will be joined to this root (instead of task cwd)",
            optional = true,
        },
    },
    builder = function(params)
        return {
            cmd = { "cargo", unpack(params.cmd) },
            args = params.args,
            cwd = params.cwd,
        }
    end,
}

---@param cwd string
---@param cb fun(error: nil|string, targets: table)
local function get_metedate(cwd, cb)
    local jid = vim.fn.jobstart({ "cargo", "metadata", "--no-deps", "--format-version=1" }, {
        cwd = cwd,
        stdout_buffered = true,
        on_stdout = function(_, output)
            local ok, data = pcall(vim.json.decode, table.concat(output, ""))
            if not ok then
                cb("JSON parse failed", {})
                return
            end
            local targets = {}
            for _, p in ipairs(data.packages) do
                for _, v in ipairs(p.targets) do
                    if v.kind[1] == "bin" and v.doc then
                        table.insert(targets, v.name)
                    end
                end
            end
            cb(nil, targets)
        end,
    })
    if jid == 0 then
        cb("Passed invalid arguments to 'cargo metadata'", {})
    elseif jid == -1 then
        cb("'cargo' is not executable", {})
    end
end

---@ type overseer.TemplateProvider
return {
    name = "cargo",
    cache_key = function(opts)
        return get_cargo_file(opts)
    end,
    condition = {
        callback = function(opts)
            return get_cargo_file(opts) and true or false
        end,
    },
    generator = function(opts, cb)
        local cwd = vim.fs.dirname(assert(get_cargo_file(opts)))
        get_metedate(cwd, function(err, targets)
            if err then
                cb({})
                log:error(err)
                return
            end
            local ret = {}
            table.insert(ret, overseer.wrap_template(template, { name = "cargo clean" }, { cmd = { "clean" } }))
            table.insert(ret, overseer.wrap_template(template, { name = "cargo check" }, { cmd = { "check" } }))
            table.insert(ret, overseer.wrap_template(template, { name = "cargo test" }, { cmd = { "test" } }))
            for _, v in ipairs(targets) do
                table.insert(ret, overseer.wrap_template(template, { name = string.format("cargo run %s", v) }, { cmd = { "run" }, args = { "--bin", v } }))
                table.insert(
                    ret,
                    overseer.wrap_template(
                        template,
                        { name = string.format("cargo run %s release", v) },
                        { cmd = { "run" }, args = { "--release", "--bin", v } }
                    )
                )
            end
            table.insert(ret, overseer.wrap_template(template, { name = "cargo build" }, { cmd = { "build" } }))
            table.insert(ret, overseer.wrap_template(template, { name = "cargo build release" }, { cmd = { "build" }, args = { "--release" } }))
            cb(ret)
        end)
    end,
}
