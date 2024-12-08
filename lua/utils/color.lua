local M = {}

function M.get_palette()
    ---@type string
    local colorscheme = vim.g.colors_name
    if colorscheme:find("catppuccin") then
        return require("catppuccin.palettes").get_palette()
    elseif colorscheme:find("onedark") then
        -- TODO: Implement onedark palette
    elseif colorscheme:find("default") then
        -- TODO: Implement default palette
    elseif colorscheme:find("tokyonight") then
        -- TODO : Implement tokyonight palette
    elseif colorscheme:find("vscode") then
        -- TODO : Implement vscode palette
    else
        return {
            rosewater = "#DC8A78",
            flamingo = "#DD7878",
            mauve = "#CBA6F7",
            pink = "#F5C2E7",
            red = "#E95678",
            maroon = "#B33076",
            peach = "#FF8700",
            yellow = "#F7BB3B",
            green = "#AFD700",
            sapphire = "#36D0E0",
            blue = "#61AFEF",
            sky = "#04A5E5",
            teal = "#B5E8E0",
            lavender = "#7287FD",
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
