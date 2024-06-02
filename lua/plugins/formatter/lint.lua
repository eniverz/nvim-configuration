return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function (_, opts)
        local lint = require("lint")

        lint.linters_by_ft = opts.linters_by_ft or {}
        for name, linter in pairs(opts.linters or {}) do
            local base = lint.linters[name]
            lint.linters[name] = (type(linter) == "table" and type(base) == "table")
            and vim.tbl_deep_extend("force", base, linter)
            or linter
        end

        local valid_linters = function(ctx, linters)
            if not linters then return {} end
            return vim.tbl_filter(function(name)
                local linter = lint.linters[name]
                return linter
                    and vim.fn.executable(linter.cmd) == 1
                    and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
            end, linters)
        end

        local orig_resolve_linter_by_ft = lint._resolve_linter_by_ft
        lint._resolve_linter_by_ft = function(...)
            local ctx = { filename = vim.api.nvim_buf_get_name(0) }
            ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")

            local linters = valid_linters(ctx, orig_resolve_linter_by_ft(...))
            if not linters[1] then linters = valid_linters(ctx, lint.linters_by_ft["_"]) end -- fallback
            require("utils.core").list_insert_unique(linters, valid_linters(ctx, lint.linters_by_ft["*"])) -- global

            return linters
        end


        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = vim.api.nvim_create_augroup("Lint", { clear = true }),
            callback = function ()
                lint.try_lint()
            end,
        })
    end
}
