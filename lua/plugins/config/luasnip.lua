return function(_, opts)
    local snippet_path = vim.fn.stdpath("config") .. "/snips/"
    if not vim.tbl_contains(vim.opt.rtp:get(), snippet_path) then
        vim.opt.rtp:append(snippet_path)
    end

    require("luasnip").config.setup(opts)

    vim.tbl_map(function(type) require("luasnip.loaders.from_" .. type).lazy_load() end, { "lua", "vscode", "snipmate" })
end
