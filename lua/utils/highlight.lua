local M = {}
local v = vim

local alias_to_key_map = {
    text = 'guifg',
    fg = 'guifg',
    bg = 'guibg',
}

local function map_join(map)
    local list = {}


    for k, val in pairs(map) do
        local key = alias_to_key_map[k] or k
        table.insert(list, key .. '=' .. val)
    end

    return table.concat(list, ' ')
end

function M.HighlightGroups(highlights)
    local highlight_groups = {}

    for name, colors in pairs(highlights) do
        highlight_groups[name] = {
            name = name,
            colors = map_join(colors),
        }
    end

    return highlight_groups
end


function M:new()
    self.new_called = true
    self.highlight_groups_list = {}

    return self
end

function M:__instance_validation()
    if not self.new_called then
        error('Highlighter: call new() before using this class')
    end
end

function M:add(highlight_groups)
    self:__instance_validation()

    table.insert(self.highlight_groups_list, highlight_groups)

    return self
end

function M:register_highlights()
    self:__instance_validation()

    for _, highlight_groups in ipairs(self.highlight_groups_list) do
        for _, highlight_group in pairs(highlight_groups) do
            v.cmd(
                string.format(
                    'highlight %s %s',
                    highlight_group.name,
                    highlight_group.colors
                )
            )
        end
    end

    return self
end

return M
