return {
    "nvimtools/none-ls.nvim",
    main = "null-ls",
    dependencies = {
        { "nvim-lua/plenary.nvim", lazy = true },
        {
            "jay-babu/mason-null-ls.nvim",
            dependencies = { "williamboman/mason.nvim" },
            cmd = { "NullLsInstall", "NullLsUninstall" },
        },
    },
    event = { "CursorHold", "CursorHoldI" },
    config = require("plugins.config.none-ls")
}
