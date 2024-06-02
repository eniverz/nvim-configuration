return {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = { "CursorHold", "CursorHoldI", "BufReadPre", "BufNewFile" },
    dependencies = {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim", cmd = { "LspInstall", "LspUninstall" } },
        {
            "Jint-lzxy/lsp_signature.nvim",
            opts = {
                bind = true,
                -- TODO: Remove the following line when nvim-cmp#1613 gets resolved
                check_completion_visible = false,
                floating_window = true,
                floating_window_above_cur_line = true,
                hi_parameter = "Search",
                hint_enable = true,
                transparency = nil, -- disabled by default, allow floating win transparent value 1~100
                wrap = true,
                zindex = 45, -- avoid overlap with nvim.cmp
                handler_opts = { border = "single" },
            },
            config = function(_, opts)
                require("lsp_signature").setup(opts)
            end,
        },
        {
            "folke/neodev.nvim",
            config = true,
            lazy = true,
        },
        { "folke/neoconf.nvim", lazy = true, opts = {} },
    },
    config = function()
        local nvim_lsp = require("lspconfig")
        require("plugins.config.lsp.mason").setup()
        require("plugins.config.lsp.mason-lspconfig").setup()

        --vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        --    require("noice.lsp.signature").on_signature,
        --    { border = 'rounded' }
        --)

        local opts = {
            capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        }
        -- Setup lsps that are not supported by `mason.nvim` but supported by `nvim-lspconfig` here.
        if vim.fn.executable("dart") == 1 then
            local _opts = require("plugins.config.lsp.servers.dartls")
            local final_opts = vim.tbl_deep_extend("keep", _opts, opts)
            nvim_lsp.dartls.setup(final_opts)
        end

        vim.api.nvim_command([[LspStart]]) -- Start LSPs
    end,
}
