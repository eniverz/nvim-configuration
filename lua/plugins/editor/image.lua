return {
    "3rd/image.nvim",
    dependencies = {
        {
            "vhyrro/luarocks.nvim",
            priority = 1001, -- this plugin needs to run before anything else
            opts = {
                rocks = { "magick" },
            },
        },
        "leafo/magick",
    },
    opts = {
        backend = "kitty",
        integrations = {
            markdown = {
                enabled = true,
                clear_in_insert_mode = false,
                download_remote_images = false,
                only_render_image_at_cursor = false,
                filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
            },
            html = {
                enabled = true,
                clear_in_insert_mode = false,
                download_remote_images = true,
                only_render_image_at_cursor = false,
                filetypes = { "markdown", "html", "tsx" },
            },
            css = {
                enabled = false,
            },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        editor_only_render_when_focused = true, -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        hijack_file_patterns = {
            "*.png",
            "*.jpg",
            "*.jpeg",
            "*.gif",
            "*.webp",
            "*.PNG",
            "*.JPG",
            "*.JPEG",
            "*.GIF",
            "*.WEBP",
        }, -- render image files as images when opened
    },
    config = function(_, opts)
        require("image").setup(opts)
    end,
}
