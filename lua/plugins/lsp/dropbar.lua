-- dropbar with click enabled
return {
    "Bekaboo/dropbar.nvim",
    keys = {
        {"<leader>;", function()
            require("dropbar.api").pick()
        end, desc = "Dropbar: pick symbols on bar"}
    },
}
