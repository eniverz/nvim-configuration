return {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim" },
    lazy = true,
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
        handlers = {
            function(config)
                local dap_name = config.name
                local ok, custom_handler = pcall(require, "config.dap." .. dap_name)
                if not ok then
                    -- Default to use factory config for clients(s) that doesn't include a spec
                    require("mason-nvim-dap").default_setup(config)
                    return
                end
                if not type(custom_handler) == "function" then
                    error("Custom handler must be a function, got " .. type(custom_handler))
                    return
                end
                custom_handler(config)
            end,
        },
    },
    config = function(_, opts)
        require("mason-nvim-dap").setup(opts)
    end,
}
