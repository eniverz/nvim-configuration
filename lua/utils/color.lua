local M = {}

function M.get_lualine_theme()
    local colorscheme = vim.g.colors_name
    if colorscheme:find("onedark") then
        return "onedark-nvim"
    elseif colorscheme:find("vscode") then
        return "vscode"
    elseif colorscheme:find("tokyonight") then
        return "tokyonight"
    else
        local colors = colorscheme:find("catppuccin") and require("catppuccin.palettes").get_palette()
            or {
                flamingo = "#DD7878",
                peach = "#FF8700",
                green = "#AFD700",
                teal = "#B5E8E0",
                lavender = "#7287FD",
                text = "#F2F2BF",
                subtext0 = "#A6ADC8",
                surface0 = "#302D41",
            }

        local universal_bg = require("config.scheme").transparent_background and "NONE" or colors.mantle
        return {
            normal = {
                a = { fg = colors.lavender, bg = colors.surface0, gui = "bold" },
                b = { fg = colors.text, bg = universal_bg },
                c = { fg = colors.text, bg = universal_bg },
            },
            command = {
                a = { fg = colors.peach, bg = colors.surface0, gui = "bold" },
            },
            insert = {
                a = { fg = colors.green, bg = colors.surface0, gui = "bold" },
            },
            visual = {
                a = { fg = colors.flamingo, bg = colors.surface0, gui = "bold" },
            },
            terminal = {
                a = { fg = colors.teal, bg = colors.surface0, gui = "bold" },
            },
            replace = {
                a = { fg = colors.red, bg = colors.surface0, gui = "bold" },
            },
            inactive = {
                a = { fg = colors.subtext0, bg = universal_bg, gui = "bold" },
                b = { fg = colors.subtext0, bg = universal_bg },
                c = { fg = colors.subtext0, bg = universal_bg },
            },
        }
    end
end

---Sets a global highlight group.
---@param name string @Highlight group name, e.g. "ErrorMsg"
---@param foreground string @The foreground color
---@param background? string @The background color
---@param italic? boolean
function M.set_global_hl(name, foreground, background, italic)
    vim.api.nvim_set_hl(0, name, {
        fg = foreground,
        bg = background,
        italic = italic == true,
    })
end

return M
