return {
  {
    "mrcjkb/rustaceanvim",
    lazy = true,
    version = "^4",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function(_, opts)
      vim.g.rustaceanvim = {
        -- Disable automatic DAP configuration to avoid conflicts with previous user configs
        dap = {
          adapter = false,
          configuration = false,
          autoload_configurations = false,
        },
      }
      require("rustaceanvim").setup(opts)
    end
  },
  {
    "Saecki/crates.nvim",
    lazy = true,
    event = "BufReadPost Cargo.toml",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = require("plugins.config.crates"),
  }
}
