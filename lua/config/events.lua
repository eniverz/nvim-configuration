local autocmd = {}

function autocmd.nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command("augroup " .. group_name)
        vim.api.nvim_command("autocmd!")
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command("augroup END")
    end
end

-- defer setting LSP-related keymaps till LspAttach
local mapping = require("keymap.completion")
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspKeymapLoader", { clear = true }),
    callback = function(event)
        if not _G._debugging then
            mapping.lsp(event.buf)
        end
    end,
})

-- auto close NvimTree
vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
    pattern = "NvimTree_*",
    callback = function()
        local layout = vim.api.nvim_call_function("winlayout", {})
        if
            layout[1] == "leaf"
            and vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_win_get_buf(layout[2]) }) == "NvimTree"
            and layout[3] == nil
        then
            vim.api.nvim_command([[confirm quit]])
        end
    end,
})

-- auto close some filetype with <q>
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "qf",
        "help",
        "man",
        "notify",
        "nofile",
        "lspinfo",
        "terminal",
        "prompt",
        "toggleterm",
        "copilot",
        "startuptime",
        "tsplayground",
        "PlenaryTestPopup",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.api.nvim_buf_set_keymap(event.buf, "n", "q", "<CMD>close<CR>", { silent = true })
    end,
})

-- auto refresh buffers
vim.api.nvim_create_autocmd({ "BufAdd", "BufEnter", "TabNewEntered" }, {
    group = vim.api.nvim_create_augroup("BuflineAdd", { clear = true }),
    desc = "Update buffers when adding new buffers",
    callback = function(args)
        local buf_utils = require("utils.buffer")
        if not vim.t.bufs then
            vim.t.bufs = {}
        end
        if not buf_utils.is_valid(args.buf) then
            return
        end
        if args.buf ~= buf_utils.current_buf then
            buf_utils.last_buf = buf_utils.is_valid(buf_utils.current_buf) and buf_utils.current_buf or nil
            buf_utils.current_buf = args.buf
        end
        local bufs = vim.t.bufs
        if not vim.tbl_contains(bufs, args.buf) then
            table.insert(bufs, args.buf)
            vim.t.bufs = bufs
        end
        vim.t.bufs = vim.tbl_filter(buf_utils.is_valid, vim.t.bufs)
    end,
})
vim.api.nvim_create_autocmd({ "BufDelete", "TermClose" }, {
    group = vim.api.nvim_create_augroup("BuflineDel", { clear = true }),
    desc = "Update buffers when deleting buffers",
    callback = function(args)
        if not vim.t.bufs then
            vim.t.bufs = {}
        end
        for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
            local bufs = vim.t[tab].bufs
            if bufs then
                for i, bufnr in ipairs(bufs) do
                    if bufnr == args.buf then
                        table.remove(bufs, i)
                        vim.t[tab].bufs = bufs
                        break
                    end
                end
            end
        end
        vim.t.bufs = vim.tbl_filter(require("utils.buffer").is_valid, vim.t.bufs)
        vim.cmd.redrawtabline()
    end,
})

function autocmd.load_autocmds()
    local definitions = {
        lazy = {},
        bufs = {
            -- Reload vim config automatically
            {
                "BufWritePost",
                [[$VIM_PATH/{*.vim,*.yaml,vimrc} nested source $MYVIMRC | redraw]],
            },
            -- Reload Vim script automatically if setlocal autoread
            {
                "BufWritePost,FileWritePost",
                "*.vim",
                [[nested if &l:autoread > 0 | source <afile> | echo 'source ' . bufname('%') | endif]],
            },
            { "BufWritePre", "/tmp/*", "setlocal noundofile" },
            { "BufWritePre", "COMMIT_EDITMSG", "setlocal noundofile" },
            { "BufWritePre", "MERGE_MSG", "setlocal noundofile" },
            { "BufWritePre", "*.tmp", "setlocal noundofile" },
            { "BufWritePre", "*.bak", "setlocal noundofile" },
            -- auto place to last edit
            {
                "BufReadPost",
                "*",
                [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif]],
            },
            -- Auto toggle fcitx5
            -- {"InsertLeave", "* :silent", "!fcitx5-remote -c"},
            -- {"BufCreate", "*", ":silent !fcitx5-remote -c"},
            -- {"BufEnter", "*", ":silent !fcitx5-remote -c "},
            -- {"BufLeave", "*", ":silent !fcitx5-remote -c "}
        },
        wins = {
            -- Highlight current line only on focused window
            {
                "WinEnter,BufEnter,InsertLeave",
                "*",
                [[if ! &cursorline && &filetype !~# '^\(dashboard\|clap_\)' && ! &pvw | setlocal cursorline | endif]],
            },
            {
                "WinLeave,BufLeave,InsertEnter",
                "*",
                [[if &cursorline && &filetype !~# '^\(dashboard\|clap_\)' && ! &pvw | setlocal nocursorline | endif]],
            },
            -- Attempt to write shada when leaving nvim
            {
                "VimLeave",
                "*",
                [[if has('nvim') | wshada | else | wviminfo! | endif]],
            },
            -- Check if file changed when its window is focus, more eager than 'autoread'
            { "FocusGained", "* checktime" },
            -- Equalize window dimensions when resizing vim window
            { "VimResized", "*", [[tabdo wincmd =]] },
        },
        ft = {
            { "FileType", "alpha", "set showtabline=0" },
            { "FileType", "markdown", "set wrap" },
            { "FileType", "make", "set noexpandtab shiftwidth=8 softtabstop=0" },
            { "FileType", "dap-repl", "lua require('dap.ext.autocompl').attach()" },
            {
                "FileType",
                "*",
                [[setlocal formatoptions-=cro]],
            },
            {
                "FileType",
                "c,cpp",
                "nnoremap <leader>H :ClangdSwitchSourceHeaderVSplit<CR>",
            },
        },
        yank = {
            {
                "TextYankPost",
                "*",
                [[silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=300})]],
            },
        },
    }
    autocmd.nvim_create_augroups(definitions)
end

autocmd.load_autocmds()
