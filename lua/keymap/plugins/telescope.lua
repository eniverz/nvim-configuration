local bind = require("keymap.bind")
local map_callback = bind.map_callback
local map_cu = bind.map_cu

if vim.fn.executable("git") then
    bind.nvim_load_mapping({
        ["n|<leader>gB"] = map_callback(function()
                require("telescope.builtin").git_branches({ use_file_path = true })
            end)
            :with_silent()
            :with_noremap()
            :with_desc("find: git branches"),
        ["n|<leader>gc"] = map_callback(function()
                require("telescope.builtin").git_commits({ use_file_path = true })
            end)
            :with_silent()
            :with_noremap()
            :with_desc("find: git commits"),
        ["n|<leader>gC"] = map_callback(function()
                require("telescope.builtin").git_bcommits({ use_file_path = true })
            end)
            :with_silent()
            :with_noremap()
            :with_desc("find: git commits(current file)"),
        ["n|<leader>gt"] = map_callback(function()
                require("telescope.builtin").git_status({ use_file_path = true })
            end)
            :with_silent()
            :with_noremap()
            :with_desc("find: git status"),
    })
end
bind.nvim_load_mapping({
    ["n|<leader>ft"] = map_callback(function()
            require("telescope.builtin").colorscheme({ enable_preview = true })
        end)
        :with_noremap()
        :with_silent()
        :with_desc("ui: Change colorscheme for current session"),
    ["n|<leader>f<CR>"] = map_callback(function()
            require("telescope.builtin").resume()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("find: resume previous change"),
    ["n|<leader>f'"] = map_callback(function()
            require("telescope.builtin").marks()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("find: marks"),
    ["n|<leader>f/"] = map_callback(function()
            require("telescope.builtin").current_buffer_fuzzy_find()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("find: in current buffer"),
    ["n|<leader>fb"] = map_callback(function()
            require("telescope.builtin").buffers()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("find: buffer"),
    ["n|<leader>fc"] = map_callback(function()
            require("telescope.builtin").commands()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("find: commands"),
    ["n|<leader>ff"] = map_callback(function()
            require("telescope.builtin").find_files()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("find: files"),
    ["n|<leader>fF"] = map_callback(function()
            require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
        end)
        :with_silent()
        :with_noremap()
        :with_desc("find: all files"),
    ["n|<leader>fH"] = map_callback(function()
            require("telescope.builtin").help_tags()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("find: helps"),
    ["n|<leader>fk"] = map_callback(function()
            require("telescope.builtin").keymaps()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("find: keymaps"),
    ["n|<leader>fe"] = map_callback(function()
            require("telescope.builtin").oldfiles()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("find: old files"),
    ["n|<leader>fR"] = map_callback(function()
            require("telescope.builtin").registers()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("find: registers"),
    ["n|<leader>fu"] = map_callback(function()
            require("telescope").extensions.undo.undo()
        end)
        :with_noremap()
        :with_silent()
        :with_desc("edit: Show undo history"),
    ["n|<leader>fp"] = map_callback(function()
            require("telescope").extensions.projects.projects({})
        end)
        :with_noremap()
        :with_silent()
        :with_desc("find: Project"),
    ["n|<leader>fr"] = map_callback(function()
            require("telescope").extensions.frecency.frecency({})
        end)
        :with_noremap()
        :with_silent()
        :with_desc("find: File by frecency"),
    ["n|<leader>fj"] = map_callback(function()
            require("telescope.builtin").jumplist()
        end)
        :with_noremap()
        :with_silent()
        :with_desc("jump: show jumplist"),
    ["n|<leader>fw"] = map_callback(function()
            require("telescope.builtin").live_grep()
        end)
        :with_noremap()
        :with_silent()
        :with_desc("find: Word"),
    ["n|<leader>fW"] = map_callback(function()
            require("telescope.builtin").live_grep({
                additional_args = function(args)
                    return vim.list_extend(args, { "--hidden", "--no-ignore" })
                end,
            })
        end)
        :with_silent()
        :with_noremap()
        :with_desc("find: words in projects"),
    ["n|<leader>fl"] = map_callback(function()
            require("telescope").extensions.aerial.aerial()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("find: symbols"),
    ["n|<leader>fs"] = map_cu("Telescope resession"):with_noremap():with_silent():with_desc("find: Session"),

    -- for symbols
    ["n|<leader>fd"] = map_callback(function()
            require("telescope.builtin").lsp_definitions()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("find: lsp definitions"),
    ["n|<leader>fh"] = map_callback(function()
            require("telescope.builtin").lsp_references()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("find: lsp references"),
})
