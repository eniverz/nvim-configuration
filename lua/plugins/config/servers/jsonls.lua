return {
    flags = { debounce_text_changes = 500 },
    on_new_config = function(config)
        if not config.settings.json.schemas then config.settings.json.schemas = {} end
        vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
    end,
    settings = { json = { validate = { enable = true } } },
}

