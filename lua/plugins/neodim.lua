return {
    "zbirenbaum/neodim",
    lazy = true,
    commit = "9477da0",
    event = "LspAttach",
    opts = {
        alpha = 0.45,
        refresh_delay = 75, -- time in ms to wait after typing before refreshing diagnostics
        hide = {
            virtual_text = true,
            signs = false,
            underline = false,
        },
        priority = 80,
        disable = { "big_file_disabled_ft" },
    },
    config = function(_, opts)
        local blend = require("utils.color").gen_neodim_blend_attr()
        opts.blend_color = blend
        require("neodim").setup(opts)
    end,
}
