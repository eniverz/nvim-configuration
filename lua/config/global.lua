local global = {}
local os_name = vim.loop.os_uname().sysname

local function file_exists(path)
    local stat = vim.loop.fs_stat(path)
    return stat and stat.type == "file"
end

local function check_ssh_keys(home, sep)
    local k = {"id_rsa","id_ecdsa","id_ed25519","id_dsa"}
    for _, key in ipairs(k) do
        local p = home .. sep .. ".ssh" .. sep .. key
        if file_exists(p) and file_exists(p .. ".pub") then return true end
    end
    return false
end

function global:load_variables()
    self.colorscheme = "catppuccin"
    self.is_mac = os_name == "Darwin"
    self.is_linux = os_name == "Linux"
    self.is_windows = os_name == "Windows_NT"
    self.is_wsl = vim.fn.has("wsl") == 1
    self.vim_path = vim.fn.stdpath("config")
    local path_sep = self.is_windows and "\\" or "/"
    local home = self.is_windows and os.getenv("USERPROFILE") or os.getenv("HOME")
    self.home = home
    self.use_ssh = check_ssh_keys(home, path_sep)
    self.data_dir = string.format("%s/site/", vim.fn.stdpath("data"))
end

global:load_variables()

return global
