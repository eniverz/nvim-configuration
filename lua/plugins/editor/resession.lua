return {
    {
        "stevearc/resession.nvim",
        dependencies = { { "romgrk/barbar.nvim", optional = true } },
        opts = {
            tab_buf_filter = function(tabpage, bufnr)
                local dir = vim.fn.getcwd(-1, vim.api.nvim_tabpage_get_number(tabpage))
                -- ensure dir has trailing /
                dir = dir:sub(-1) ~= "/" and dir .. "/" or dir
                return vim.startswith(vim.api.nvim_buf_get_name(bufnr), dir)
            end,
            dir = require("config.settings").sessions.save_dir,
        },
        config = function(_, opts)
            local resession = require("resession")

            resession.setup(opts)
            -- Automatically save sessions on by working directory on exit
            vim.api.nvim_create_autocmd("VimLeavePre", {
                callback = function()
                    resession.save_tab(vim.fn.getcwd(), { notify = true })
                end,
            })

            -- Automatically load sessions on startup by working directory
            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function()
                    -- Only load the session if nvim was started with no args
                    if vim.fn.argc(-1) == 0 then
                        resession.load(vim.fn.getcwd(), { silence_errors = true })
                    end
                end,
                nested = true,
            })
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        optional = true,
        dependencies = { "scottmckendry/telescope-resession.nvim" },
        opts = {
            extensions = {
                resession = {
                    prompt_title = "Find Sessions",
                    dir = require("config.settings").sessions.save_dir,
                },
            },
        },
    },
}
