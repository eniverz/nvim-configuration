-- copilot

local use_copilot = require("config.lsp").features.copilot

if use_copilot then
    return {
        "zbirenbaum/copilot.lua",
        lazy = true,
        cmd = "Copilot",
        event = "InsertEnter",
        opts = function(_, opts)
            opts = vim.tbl_deep_extend("force", opts, {
                cmp = {
                    enabled = true,
                    method = "getCompletionsCycling",
                },
                panel = {
                    -- if true, it can interfere with completions in copilot-cmp
                    enabled = false,
                },
                suggestion = {
                    -- if true, it can interfere with completions in copilot-cmp
                    enabled = false,
                },
                filetypes = {
                    ["dap-repl"] = false,
                    ["big_file_disabled_ft"] = false,
                },
            })
        end,
        dependencies = {
            {
                "zbirenbaum/copilot-cmp",
                config = function() require("copilot_cmp").setup() end
            },
        }
    }
end

return {}
