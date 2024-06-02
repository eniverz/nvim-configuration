return function(buf)
    local map_callback = require("keymap.bind").map_callback
    return {
        ["n|<leader>ls"] = map_callback(function()
                require("aerial").toggle() -- code
            end)
            :with_silent()
            :with_buffer(buf)
            :with_desc("aerial: symbol outline"),
    }
end
