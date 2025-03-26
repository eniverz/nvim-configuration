-- UI for dap
return {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    dependencies = {
        { "nvim-neotest/nvim-nio", lazy = true },
    },
    opts = { floating = { border = "rounded" } },
    config = function(_, opts)
        require("dapui").setup(opts)
    end,
}
