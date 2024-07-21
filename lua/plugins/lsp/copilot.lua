-- copilot

local use_copilot = require("config.lsp").features.copilot

if use_copilot then
    return {
        "zbirenbaum/copilot.lua",
        lazy = true,
        cmd = "Copilot",
        event = "InsertEnter",
        config = require("plugins.config.copliot"),
        dependencies = {
            {
                "zbirenbaum/copilot-cmp",
                config = function(_, opts)
                    require("copilot_cmp").setup(opts)
                end,
            },
        },
    }
end

return {}
