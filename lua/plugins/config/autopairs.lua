return function(_, opts)
    local npairs = require "nvim-autopairs"
    npairs.setup(opts)

    local core = require("utils.core")
    if not require("config.lsp").features.autopairs then npairs.disable() end
    core.on_load(
        "nvim-cmp",
        function()
            require("cmp").event:on("confirm_done",
                require("nvim-autopairs.completion.cmp").on_confirm_done { tex = false })
        end
    )
end
