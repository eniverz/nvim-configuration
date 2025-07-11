local global = require("config.global")
local settings = require("config.settings")

local load_lsp_config = function()
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        signs = true,
        underline = true,
        virtual_text = settings.settings.lsp.native_diagnostics and {
            min = settings.settings.lsp.diagnostics_level,
        } or false,
        -- set update_in_insert to false because it was enabled by lspsaga
        update_in_insert = false,
    })
    local capabilities = require("blink.cmp").get_lsp_capabilities(
        vim.tbl_extend("keep", require("lsp-file-operations").default_capabilities(), vim.lsp.protocol.make_client_capabilities())
    )
    vim.lsp.config("*", {
        capabilities = capabilities,
    })
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("my.lsp", {}),
        callback = function(args)
            local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
            if client:supports_method("textDocument/implementation") then
                -- Create a keymap for vim.lsp.buf.implementation ...
            end
            -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
            -- if client:supports_method("textDocument/completion") then
            --     -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            --     -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            --     -- client.server_capabilities.completionProvider.triggerCharacters = chars
            --     vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
            -- end
            -- Auto-format ("lint") on save.
            -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
            if not client:supports_method("textDocument/willSaveWaitUntil") and client:supports_method("textDocument/formatting") then
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
                    buffer = args.buf,
                    callback = function()
                        vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                    end,
                })
            end
        end,
    })

    local lsp_path = vim.fn.stdpath("config") .. global.path_sep .. "lsp"
    local ok, files = pcall(vim.fn.readdir, lsp_path)
    if not ok and not files then
        vim.notify("Failed to read lsp directory: " .. lsp_path, vim.log.levels.ERROR, { title = "[core] Runtime Error" })
        return
    end
    for _, server in ipairs(files) do
        if server:match("%.lua$") then
            local server_name = server:gsub("%.lua", "") -- remove .lua extension
            vim.lsp.enable(server_name)
        end
    end
end

local load_editor_keymap = function()
    vim.g.mapleader = " "
    local map = vim.keymap.set
    local opts = function(desc)
        return { desc = desc, noremap = true, silent = true }
    end
    map("n", "d", '"_d', opts("edit: Change clipboard register for delete"))
    map("v", "d", '"_d', opts("edit: Change clipboard register for delete"))
    map("n", "D", '"_D', opts("edit: Change clipboard register for delete"))
    map("v", "D", '"_D', opts("edit: Change clipboard register for delete"))
    map("n", "s", '"_s', opts("edit: Change clipboard register for delete"))
    map("v", "s", '"_s', opts("edit: Change clipboard register for delete"))
    map("n", "S", '"_S', opts("edit: Change clipboard register for delete"))
    map("v", "S", '"_S', opts("edit: Change clipboard register for delete"))
    map("n", "c", '"_c', opts("edit: Change clipboard register for delete"))
    map("v", "c", '"_c', opts("edit: Change clipboard register for delete"))
    map("n", "C", '"_C', opts("edit: Change clipboard register for delete"))
    map("v", "C", '"_C', opts("edit: Change clipboard register for delete"))
    map("n", "<C-Backspace>", '"_db', opts("edit: Delete word forward"))
    map("i", "<C-Backspace>", '<C-o>"_db', opts("edit: Delete word forward"))
    map("n", "<C-Del>", '"_dw', opts("edit: delete word backward"))
    map("i", "<C-Del>", '<C-o>"_dw', opts("edit: delete word backward"))

    map("n", "<leader>q", "<Cmd>confirm q<CR>", opts("edit: force quit"))

    map("n", "<Tab>", ">>", opts("edit: increase indent"))
    map("v", "<Tab>", ">gv", opts("edit: increase indent"))
    map("n", "<S-Tab>", "<<", opts("edit: decrease indent"))
    map("v", "<S-Tab>", "<gv", opts("edit: Decrease indent"))
    map("n", "<leader>lF", "normal! gg=G``", opts("edit: Format indent"))

    map("n", "<C-s>", "<Esc><Esc>:w<CR>", opts("edit: Save file"))
    map("i", "<C-s>", "<Esc><Esc><Esc>:w<CR>", opts("edit: Save file"))

    map("i", "<C-CR>", "<C-o>o", opts("edit: New line"))
    map("i", "<S-CR>", "<C-o>o", opts("edit: New line"))

    map("n", "<C-d>", "<Cmd>copy .<CR>", opts("edit: Duplicate line"))
    map("i", "<C-d>", "<Esc><Esc><Esc><Cmd>copy .<CR>i", opts("edit: Duplicate line"))
    map("v", "<C-d>", ":copy '><CR>gv", opts("edit: Duplicate line"))

    map("n", "r", "<Cmd>redo<CR>", opts("edit: Redo"))
    map("n", "u", "<Cmd>undo<CR>", opts("edit: Undo"))

    map("n", "<A-S-Left>", "<C-o>", opts("edit: Jump previous cursor position"))
    map("n", "<A-S-Right>", "<C-i>", opts("edit: Jump next cursor position"))

    map("n", "<leader>li", ":checkhealth vim.lsp", opts("lsp: check enabled lsp"))

    map("n", "<Esc>", function()
        pcall(vim.cmd.noh)
    end, opts("edit: Clear search highlight"))
end

local shell_config = function()
    if global.is_windows then
        if not (vim.fn.executable("pwsh") == 1 or vim.fn.executable("powershell") == 1) then
            vim.notify(
                [[
Failed to setup terminal config

PowerShell is either not installed, missing from PATH, or not executable;
cmd.exe will be used instead for `:!` (shell bang) and toggleterm.nvim.

You're recommended to install PowerShell for better experience.]],
                vim.log.levels.WARN,
                { title = "[core] Runtime Warning" }
            )
            return
        end

        local basecmd = "-NoLogo -MTA -ExecutionPolicy RemoteSigned"
        local ctrlcmd = "-Command [console]::InputEncoding = [console]::OutputEncoding = [System.Text.Encoding]::UTF8"
        vim.api.nvim_set_option_value("shell", vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell", {})
        vim.api.nvim_set_option_value("shellcmdflag", string.format("%s %s;", basecmd, ctrlcmd), {})
        vim.api.nvim_set_option_value("shellredir", "-RedirectStandardOutput %s -NoNewWindow -Wait", {})
        vim.api.nvim_set_option_value("shellpipe", "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode", {})
        vim.api.nvim_set_option_value("shellquote", nil, {})
        vim.api.nvim_set_option_value("shellxquote", nil, {})
    end
end

local disable_distribution_plugins = function()
    -- Disable menu loading
    vim.g.did_install_default_menus = 1
    vim.g.did_install_syntax_menu = 1

    -- Comment this if you define your own filetypes in `after/ftplugin`
    -- vim.g.did_load_filetypes = 1

    -- Do not load native syntax completion
    vim.g.loaded_syntax_completion = 1

    -- Do not load spell files
    vim.g.loaded_spellfile_plugin = 1

    -- Whether to load netrw by default
    -- vim.g.loaded_netrw = 1
    -- vim.g.loaded_netrwFileHandlers = 1
    -- vim.g.loaded_netrwPlugin = 1
    -- vim.g.loaded_netrwSettings = 1
    -- newtrw liststyle: https://medium.com/usevim/the-netrw-style-options-3ebe91d42456
    vim.g.netrw_liststyle = 3

    -- Do not load tohtml.vim
    vim.g.loaded_2html_plugin = 1

    -- Do not load zipPlugin.vim, gzip.vim and tarPlugin.vim (all of these plugins are
    -- related to reading files inside compressed containers)
    vim.g.loaded_gzip = 1
    vim.g.loaded_tar = 1
    vim.g.loaded_tarPlugin = 1
    vim.g.loaded_vimball = 1
    vim.g.loaded_vimballPlugin = 1
    vim.g.loaded_zip = 1
    vim.g.loaded_zipPlugin = 1

    -- Do not use builtin matchit.vim and matchparen.vim because we're using vim-matchup
    vim.g.loaded_matchit = 1
    vim.g.loaded_matchparen = 1

    -- Disable sql omni completion
    vim.g.loaded_sql_completion = 1

    -- Set this to 0 in order to disable native EditorConfig support
    vim.g.editorconfig = 1

    -- Disable remote plugins
    -- NOTE:
    --  > Disabling rplugin.vim will make `wilder.nvim` complain about missing rplugins during :checkhealth,
    --  > but since it's config doesn't require python rtp (strictly), it's fine to ignore that for now.
    -- vim.g.loaded_remote_plugins = 1
end

local clipboard_config = function()
    if global.is_mac then
        vim.g.clipboard = {
            name = "macOS-clipboard",
            copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
            paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
            cache_enabled = 0,
        }
    elseif global.is_wsl then
        vim.g.clipboard = {
            name = "win32yank-wsl",
            copy = {
                ["+"] = "win32yank.exe -i --crlf",
                ["*"] = "win32yank.exe -i --crlf",
            },
            paste = {
                ["+"] = "win32yank.exe -o --lf",
                ["*"] = "win32yank.exe -o --lf",
            },
            cache_enabled = 0,
        }
    elseif global.is_linux then
        vim.g.clipboard = {
            name = "copyq",
            copy = {
                ["+"] = "copyq add -",
                ["*"] = "copyq add -",
            },
            paste = {
                ["+"] = "copyq paste -",
                ["*"] = "copyq paste -",
            },
            cache_enabled = 0,
        }
    end
end

local load_options = function()
    for opt, val in pairs(settings.opts) do
        vim.o[opt] = val
    end
end

local load_core = function()
    vim.api.nvim_command("set background=" .. require("config.scheme").background)

    disable_distribution_plugins()
    load_options()
    shell_config()
    clipboard_config()
    load_editor_keymap()

    require("lazy_setup")
    load_lsp_config()
end

load_core()
