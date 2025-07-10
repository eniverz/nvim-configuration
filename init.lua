local global = require("config.global")
local settings = require("config.settings")

local load_editor_keymap = function ()
    vim.g.mapleader = " "
    local map = vim.keymap.set
    local opts = function (desc) return { desc = desc, noremap = true, silent = true } end
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

    map("n", "<Esc>", function() pcall(vim.cmd.noh) end, opts("edit: Clear search highlight"))
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

local load_core = function ()
    vim.api.nvim_command("set background=" .. require("config.scheme").background)

    load_options()
    shell_config()
    clipboard_config()
    load_editor_keymap()

    require("lazy_setup")
end

load_core()
