local M = {}

function M.get_lualine_theme()
    local colorscheme = vim.g.colors_name
    if colorscheme:find("onedark") then
        return colorscheme
    elseif colorscheme:find("vscode") then
        return "vscode"
    elseif colorscheme:find("tokyonight") then
        return "tokyonight"
    elseif colorscheme:find("nord") then
        return "nord"
    else
        local colors = colorscheme:find("catppuccin") and require("catppuccin.palettes").get_palette()
            or {
                rosewater = "#f5e0dc",
                flamingo = "#f2cdcd",
                pink = "#f5c2e7",
                mauve = "#cba6f7",
                red = "#f38ba8",
                maroon = "#eba0ac",
                peach = "#fab387",
                yellow = "#f9e2af",
                green = "#a6e3a1",
                teal = "#94e2d5",
                sky = "#89dceb",
                sapphire = "#74c7ec",
                blue = "#89b4fa",
                lavender = "#b4befe",
                text = "#cdd6f4",
                subtext1 = "#bac2de",
                subtext0 = "#a6adc8",
                overlay2 = "#9399b2",
                overlay1 = "#7f849c",
                overlay0 = "#6c7086",
                surface2 = "#585b70",
                surface1 = "#45475a",
                surface0 = "#313244",
                base = "#1e1e2e",
                mantle = "#181825",
                crust = "#11111b",
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
