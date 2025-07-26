-- session manager
return {
    "eniverz/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {
        dir = require("config.settings").settings.sessions.save_dir, -- directory where session files are saved
        -- minimum number of file buffers that need to be open to save
        -- Set to 0 to always save
        need = 3,
        branch = true, -- use git branch to save session
    },
    keys = {
        {
            "<leader>ss",
            function()
                local persistence = require("persistence")
                persistence.fire("SavePre")
                persistence.save()
                persistence.fire("SavePost")
            end,
            desc = "Session: save",
        },
        {
            "<leader>sl",
            function()
                require("persistence").load()
            end,
            desc = "Session: load current",
        },
        {
            "<leader>sL",
            function()
                require("persistence").load({ last = true })
            end,
            desc = "Session: load last",
        },
        {
            "<leader>st",
            function()
                local persistence = require("persistence")
                if persistence._active then
                    persistence.stop()
                    vim.notify("Session auto save is disabled", vim.log.levels.WARN, { title = "Persistence" })
                else
                    persistence.start()
                    vim.notify("Session auto save is enabled", vim.log.levels.INFO, { title = "Persistence" })
                end
            end,
            desc = "Session: toggle auto save",
        },
        {
            "<leader>fs",
            function()
                require("persistence").select()
            end,
            desc = "Session: select to load",
        },
    },
    config = function(_, opts)
        require("persistence").setup(opts)
    end,
}
