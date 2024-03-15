return function()
    local stats = require("lazy").stats()
    local opt = {
        theme = 'doom',
        config = {
            -- week_header = { enable = true },
            header = require("core.settings").dashboard_image, --your header
            center = {
                {
                    icon = ' ',
                    icon_hl = "Title",
                    desc = 'Scheme Change                                  ',
                    desc_hl = "String",
                    key = '<leader> f f',
                    key_hl = "Number",
                    key_format = ' %s', -- remove default surrounding `[]`
                    action = 'lua print(stats.startuptime)'
                },
                {
                    icon_hl = "Title",
                    desc_hl = "String",
                    key_hl = "Number",
                    icon = ' ',
                    desc = 'File frecency',
                    key = '<leader> f r',
                    key_format = ' %s', -- remove default surrounding `[]`
                    action = 'Telescope frecency'
                },
                {
                    icon_hl = "Title",
                    desc_hl = "String",
                    key_hl = "Number",
                    icon = '󰋚 ',
                    desc = 'File history',
                    key = '<leader> f e',
                    key_format = ' %s', -- remove default surrounding `[]`
                    action = 'Telescope oldfiles'
                },
                {
                    icon_hl = "Title",
                    desc_hl = "String",
                    key_hl = "Number",
                    icon = ' ',
                    desc = 'Project find',
                    key = '<leader> f p',
                    key_format = ' %s', -- remove default surrounding `[]`
                    action = 'Telescope projects'
                },
                {
                    icon_hl = "Title",
                    desc_hl = "String",
                    key_hl = "Number",
                    icon = '󰈞 ',
                    desc = 'File find',
                    key = '<leader> f f',
                    key_format = ' %s', -- remove default surrounding `[]`
                    action = 'Telescope find_files'
                },
                {
                    icon_hl = "Title",
                    desc_hl = "String",
                    key_hl = "Number",
                    icon = ' ',
                    desc = 'Word find',
                    key = '<leader> f w',
                    key_format = ' %s', -- remove default surrounding `[]`
                    action = 'Telescope live_grep'
                }
            },
            footer = {
                "   Have Fun with neovim"
                .. "  󰀨 v"
                .. vim.version().major
                .. "."
                .. vim.version().minor
                .. "."
                .. vim.version().patch
                .. "  󰂖 "
                .. stats.count
                .. " plugins"
            } --your footer
        }
    }
    require("modules.utils").load_plugin("dashboard", opt)
end
