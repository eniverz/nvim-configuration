## aerial

maps.n["<Leader>lS"] = { function() require("aerial").toggle() end, desc = "Symbols outline" }

## alpha

maps.n["<Leader>h"] = {
function()
local wins = vim.api.nvim_tabpage_list_wins(0)
if #wins > 1 and vim.bo[vim.api.nvim_win_get_buf(wins[1])].filetype == "neo-tree" then
vim.fn.win_gotoid(wins[2]) -- go to non-neo-tree window to toggle alpha
end
require("alpha").start(false)
end,
desc = "Home Screen",
}

## autopairs

maps.n["<Leader>ua"] = { function() require("astrocore.toggles").autopairs() end, desc = "Toggle autopairs" }

## cmp_luasnip

### nvim-cmp

maps.n["<Leader>uc"] =
{ function() require("astrocore.toggles").buffer_cmp() end, desc = "Toggle autocompletion (buffer)" }
maps.n["<Leader>uC"] =
{ function() require("astrocore.toggles").cmp() end, desc = "Toggle autocompletion (global)" }

## Colorize

maps.n["<Leader>uz"] = { "<Cmd>ColorizerToggle<CR>", desc = "Toggle color highlight" }

## comment

maps.n["<Leader>/"] = {
function()
return require("Comment.api").call(
"toggle.linewise." .. (vim.v.count == 0 and "current" or "count_repeat"),
"g@$"
)()
end,
expr = true,
silent = true,
desc = "Toggle comment line",
}
maps.x["<Leader>/"] = {
"<Esc><Cmd>lua require('Comment.api').locked('toggle.linewise')(vim.fn.visualmode())<CR>",
desc = "Toggle comment",
}

## dap

maps.n["<Leader>d"] = vim.tbl_get(opts, "\_map_sections", "d")
-- modified function keys found with `showkey -a` in the terminal to get key code
-- run `nvim -V3log +quit` and search through the "Terminal info" in the `log` file for the correct keyname
maps.n["<F5>"] = { function() require("dap").continue() end, desc = "Debugger: Start" }
maps.n["<F17>"] = { function() require("dap").terminate() end, desc = "Debugger: Stop" } -- Shift+F5
maps.n["<F21>"] = { -- Shift+F9
function()
vim.ui.input({ prompt = "Condition: " }, function(condition)
if condition then require("dap").set_breakpoint(condition) end
end)
end,
desc = "Debugger: Conditional Breakpoint",
}
maps.n["<F29>"] = { function() require("dap").restart_frame() end, desc = "Debugger: Restart" } -- Control+F5
maps.n["<F6>"] = { function() require("dap").pause() end, desc = "Debugger: Pause" }
maps.n["<F9>"] = { function() require("dap").toggle_breakpoint() end, desc = "Debugger: Toggle Breakpoint" }
maps.n["<F10>"] = { function() require("dap").step_over() end, desc = "Debugger: Step Over" }
maps.n["<F11>"] = { function() require("dap").step_into() end, desc = "Debugger: Step Into" }
maps.n["<F23>"] = { function() require("dap").step_out() end, desc = "Debugger: Step Out" } -- Shift+F11
maps.n["<Leader>db"] = { function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint (F9)" }
maps.n["<Leader>dB"] = { function() require("dap").clear_breakpoints() end, desc = "Clear Breakpoints" }
maps.n["<Leader>dc"] = { function() require("dap").continue() end, desc = "Start/Continue (F5)" }
maps.n["<Leader>dC"] = {
function()
vim.ui.input({ prompt = "Condition: " }, function(condition)
if condition then require("dap").set_breakpoint(condition) end
end)
end,
desc = "Conditional Breakpoint (S-F9)",
}
maps.n["<Leader>di"] = { function() require("dap").step_into() end, desc = "Step Into (F11)" }
maps.n["<Leader>do"] = { function() require("dap").step_over() end, desc = "Step Over (F10)" }
maps.n["<Leader>dO"] = { function() require("dap").step_out() end, desc = "Step Out (S-F11)" }
maps.n["<Leader>dq"] = { function() require("dap").close() end, desc = "Close Session" }
maps.n["<Leader>dQ"] = { function() require("dap").terminate() end, desc = "Terminate Session (S-F5)" }
maps.n["<Leader>dp"] = { function() require("dap").pause() end, desc = "Pause (F6)" }
maps.n["<Leader>dr"] = { function() require("dap").restart_frame() end, desc = "Restart (C-F5)" }
maps.n["<Leader>dR"] = { function() require("dap").repl.toggle() end, desc = "Toggle REPL" }
maps.n["<Leader>ds"] = { function() require("dap").run_to_cursor() end, desc = "Run To Cursor" }

### dap-ui

maps.n["<Leader>d"] = vim.tbl_get(opts, "\_map_sections", "d")
maps.v["<Leader>d"] = vim.tbl_get(opts, "\_map_sections", "d")
maps.n["<Leader>dE"] = {
function()
vim.ui.input({ prompt = "Expression: " }, function(expr)
if expr then require("dapui").eval(expr, { enter = true }) end
end)
end,
desc = "Evaluate Input",
}
maps.n["<Leader>du"] = { function() require("dapui").toggle() end, desc = "Toggle Debugger UI" }
maps.n["<Leader>dh"] = { function() require("dap.ui.widgets").hover() end, desc = "Debugger Hover" }
maps.v["<Leader>dE"] = { function() require("dapui").eval() end, desc = "Evaluate Input" }

## gitsigns

maps.n["<Leader>g"] = vim.tbl_get(opts, "\_map_sections", "g")
maps.n["]g"] = { function() require("gitsigns").next_hunk() end, desc = "Next Git hunk" }
maps.n["[g"] = { function() require("gitsigns").prev_hunk() end, desc = "Previous Git hunk" }
maps.n["<Leader>gl"] = { function() require("gitsigns").blame_line() end, desc = "View Git blame" }
maps.n["<Leader>gL"] =
{ function() require("gitsigns").blame_line { full = true } end, desc = "View full Git blame" }
maps.n["<Leader>gp"] = { function() require("gitsigns").preview_hunk_inline() end, desc = "Preview Git hunk" }
maps.n["<Leader>gh"] = { function() require("gitsigns").reset_hunk() end, desc = "Reset Git hunk" }
maps.n["<Leader>gr"] = { function() require("gitsigns").reset_buffer() end, desc = "Reset Git buffer" }
maps.n["<Leader>gs"] = { function() require("gitsigns").stage_hunk() end, desc = "Stage Git hunk" }
maps.n["<Leader>gS"] = { function() require("gitsigns").stage_buffer() end, desc = "Stage Git buffer" }
maps.n["<Leader>gu"] = { function() require("gitsigns").undo_stage_hunk() end, desc = "Unstage Git hunk" }
maps.n["<Leader>gd"] = { function() require("gitsigns").diffthis() end, desc = "View Git diff" }

## heirline

maps.n["<Leader>bb"] = {
function()
require("astroui.status.heirline").buffer_picker(function(bufnr) vim.api.nvim_win_set_buf(0, bufnr) end)
end,
desc = "Select buffer from tabline",
}
maps.n["<Leader>bd"] = {
function()
require("astroui.status.heirline").buffer_picker(
function(bufnr) require("astrocore.buffer").close(bufnr) end
)
end,
desc = "Close buffer from tabline",
}
maps.n["<Leader>b\\"] = {
function()
require("astroui.status.heirline").buffer_picker(function(bufnr)
vim.cmd.split()
vim.api.nvim_win_set_buf(0, bufnr)
end)
end,
desc = "Horizontal split buffer from tabline",
}
maps.n["<Leader>b|"] = {
function()
require("astroui.status.heirline").buffer_picker(function(bufnr)
vim.cmd.vsplit()
vim.api.nvim_win_set_buf(0, bufnr)
end)
end,
desc = "Vertical split buffer from tabline",
}

## indent blankline

maps.n["<Leader>u|"] = { "<Cmd>IBLToggle<CR>", desc = "Toggle indent guides" }

## lspconfig

maps.n["<Leader>li"] =
{ "<Cmd>LspInfo<CR>", desc = "LSP information", cond = function() return vim.fn.exists ":LspInfo" > 0 end }

## mason

        maps.n["<Leader>pm"] = { function() require("mason.ui").open() end, desc = "Mason Installer" }
        maps.n["<Leader>pM"] = { function() require("astrocore.mason").update_all() end, desc = "Mason Update" }

## neo-tree

maps.n["<Leader>e"] = { "<Cmd>Neotree toggle<CR>", desc = "Toggle Explorer" }
maps.n["<Leader>o"] = {
function()
if vim.bo.filetype == "neo-tree" then
vim.cmd.wincmd "p"
else
vim.cmd.Neotree "focus"
end
end,
desc = "Toggle Explorer Focus",
}

## notify

maps.n["<Leader>uD"] = {
function() require("notify").dismiss { pending = true, silent = true } end,
desc = "Dismiss notifications",
}

## ufo (fold code range)

maps.n["zR"] = { function() require("ufo").openAllFolds() end, desc = "Open all folds" }
maps.n["zM"] = { function() require("ufo").closeAllFolds() end, desc = "Close all folds" }
maps.n["zr"] = { function() require("ufo").openFoldsExceptKinds() end, desc = "Fold less" }
maps.n["zm"] = { function() require("ufo").closeFoldsWith() end, desc = "Fold more" }
maps.n["zp"] = { function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "Peek fold" }

## smart split

智能分屏之间光标跳转

maps.n["<C-H>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" }
maps.n["<C-J>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" }
maps.n["<C-K>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" }
maps.n["<C-L>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" }
maps.n["<C-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" }
maps.n["<C-Down>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" }
maps.n["<C-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" }
maps.n["<C-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" }

## TODO

if require("astrocore").is_available "telescope.nvim" then
maps.n["<Leader>fT"] = { "<Cmd>TodoTelescope<CR>", desc = "Find TODOs" }
end
maps.n["]T"] = { function() require("todo-comments").jump_next() end, desc = "Next TODO comment" }
maps.n["[T"] = { function() require("todo-comments").jump_prev() end, desc = "Previous TODO comment" }

## telescope

          maps.n["<Leader>f"] = vim.tbl_get(opts, "_map_sections", "f")
          if vim.fn.executable "git" == 1 then
            maps.n["<Leader>g"] = vim.tbl_get(opts, "_map_sections", "g")
            maps.n["<Leader>gb"] = {
              function() require("telescope.builtin").git_branches { use_file_path = true } end,
              desc = "Git branches",
            }
            maps.n["<Leader>gc"] = {
              function() require("telescope.builtin").git_commits { use_file_path = true } end,
              desc = "Git commits (repository)",
            }
            maps.n["<Leader>gC"] = {
              function() require("telescope.builtin").git_bcommits { use_file_path = true } end,
              desc = "Git commits (current file)",
            }
            maps.n["<Leader>gt"] =
              { function() require("telescope.builtin").git_status { use_file_path = true } end, desc = "Git status" }
          end
          maps.n["<Leader>f<CR>"] =
            { function() require("telescope.builtin").resume() end, desc = "Resume previous search" }
          maps.n["<Leader>f'"] = { function() require("telescope.builtin").marks() end, desc = "Find marks" }
          maps.n["<Leader>f/"] = {
            function() require("telescope.builtin").current_buffer_fuzzy_find() end,
            desc = "Find words in current buffer",
          }
          maps.n["<Leader>fa"] = {
            function()
              require("telescope.builtin").find_files {
                prompt_title = "Config Files",
                cwd = vim.fn.stdpath "config",
                follow = true,
              }
            end,
            desc = "Find AstroNvim config files",
          }
          maps.n["<Leader>fb"] = { function() require("telescope.builtin").buffers() end, desc = "Find buffers" }
          maps.n["<Leader>fc"] =
            { function() require("telescope.builtin").grep_string() end, desc = "Find word under cursor" }
          maps.n["<Leader>fC"] = { function() require("telescope.builtin").commands() end, desc = "Find commands" }
          maps.n["<Leader>ff"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" }
          maps.n["<Leader>fF"] = {
            function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
            desc = "Find all files",
          }
          maps.n["<Leader>fh"] = { function() require("telescope.builtin").help_tags() end, desc = "Find help" }
          maps.n["<Leader>fk"] = { function() require("telescope.builtin").keymaps() end, desc = "Find keymaps" }
          maps.n["<Leader>fm"] = { function() require("telescope.builtin").man_pages() end, desc = "Find man" }
          if is_available "nvim-notify" then
            maps.n["<Leader>fn"] =
              { function() require("telescope").extensions.notify.notify() end, desc = "Find notifications" }
          end
          maps.n["<Leader>fe"] = { function() require("telescope.builtin").oldfiles() end, desc = "Find history" }
          maps.n["<Leader>fr"] = { function() require("telescope.builtin").registers() end, desc = "Find registers" }
          maps.n["<Leader>ft"] =
            { function() require("telescope.builtin").colorscheme { enable_preview = true } end, desc = "Find themes" }
          if vim.fn.executable "rg" == 1 then
            maps.n["<Leader>fw"] = { function() require("telescope.builtin").live_grep() end, desc = "Find words" }
            maps.n["<Leader>fW"] = {
              function()
                require("telescope.builtin").live_grep {
                  additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
                }
              end,
              desc = "Find words in all files",
            }
          end
          maps.n["<Leader>ls"] = {
            function()
              if is_available "aerial.nvim" then
                require("telescope").extensions.aerial.aerial()
              else
                require("telescope.builtin").lsp_document_symbols()
              end
            end,
            desc = "Search symbols",
          }



        maps.n["<Leader>lD"] =
          { function() require("telescope.builtin").diagnostics() end, desc = "Search diagnostics" }
        if maps.n.gd then
          maps.n.gd[1] = function() require("telescope.builtin").lsp_definitions { reuse_win = true } end
        end
        if maps.n.gI then
          maps.n.gI[1] = function() require("telescope.builtin").lsp_implementations { reuse_win = true } end
        end
        --- TODO: AstroNvim v5 remove gr mapping as it's default and global
        if maps.n.gr then maps.n.gr[1] = function() require("telescope.builtin").lsp_references() end end
        if maps.n["<Leader>lR"] then
          maps.n["<Leader>lR"][1] = function() require("telescope.builtin").lsp_references() end
        end
        if maps.n.gy then
          maps.n.gy[1] = function() require("telescope.builtin").lsp_type_definitions { reuse_win = true } end
        end
        if maps.n["<Leader>lG"] then
          maps.n["<Leader>lG"][1] = function()
            vim.ui.input({ prompt = "Symbol Query: (leave empty for word under cursor)" }, function(query)
              if query then
                -- word under cursor if given query is empty
                if query == "" then query = vim.fn.expand "<cword>" end
                require("telescope.builtin").lsp_workspace_symbols {
                  query = query,
                  prompt_title = ("Find word (%s)"):format(query),
                }
              end
            end)
          end
        end

## toggleterm

        maps.n["<Leader>t"] = vim.tbl_get(opts, "_map_sections", "t")
        if vim.fn.executable "git" == 1 and vim.fn.executable "lazygit" == 1 then
          maps.n["<Leader>g"] = vim.tbl_get(opts, "_map_sections", "g")
          local lazygit = {
            callback = function()
              local worktree = astro.file_worktree()
              local flags = worktree and (" --work-tree=%s --git-dir=%s"):format(worktree.toplevel, worktree.gitdir)
                or ""
              astro.toggle_term_cmd("lazygit " .. flags)
            end,
            desc = "ToggleTerm lazygit",
          }
          maps.n["<Leader>gg"] = { lazygit.callback, desc = lazygit.desc }
          maps.n["<Leader>tl"] = { lazygit.callback, desc = lazygit.desc }
        end
        if vim.fn.executable "node" == 1 then
          maps.n["<Leader>tn"] = { function() astro.toggle_term_cmd "node" end, desc = "ToggleTerm node" }
        end
        local gdu = vim.fn.has "mac" == 1 and "gdu-go" or "gdu"
        if vim.fn.has "win32" == 1 and vim.fn.executable(gdu) ~= 1 then gdu = "gdu_windows_amd64.exe" end
        if vim.fn.executable(gdu) == 1 then
          maps.n["<Leader>tu"] = { function() astro.toggle_term_cmd(gdu) end, desc = "ToggleTerm gdu" }
        end
        if vim.fn.executable "btm" == 1 then
          maps.n["<Leader>tt"] = { function() astro.toggle_term_cmd "btm" end, desc = "ToggleTerm btm" }
        end
        local python = vim.fn.executable "python" == 1 and "python" or vim.fn.executable "python3" == 1 and "python3"
        if python then
          maps.n["<Leader>tp"] = { function() astro.toggle_term_cmd(python) end, desc = "ToggleTerm python" }
        end
        maps.n["<Leader>tf"] = { "<Cmd>ToggleTerm direction=float<CR>", desc = "ToggleTerm float" }
        maps.n["<Leader>th"] =
          { "<Cmd>ToggleTerm size=10 direction=horizontal<CR>", desc = "ToggleTerm horizontal split" }
        maps.n["<Leader>tv"] = { "<Cmd>ToggleTerm size=80 direction=vertical<CR>", desc = "ToggleTerm vertical split" }
        maps.n["<F7>"] = { '<Cmd>execute v:count . "ToggleTerm"<CR>', desc = "Toggle terminal" }
        maps.t["<F7>"] = { "<Cmd>ToggleTerm<CR>", desc = "Toggle terminal" }
        maps.i["<F7>"] = { "<Esc><Cmd>ToggleTerm<CR>", desc = "Toggle terminl" }
        maps.n["<C-'>"] = { '<Cmd>execute v:count . "ToggleTerm"<CR>', desc = "Toggle terminal" } -- requires terminal that supports binding <C-'>
        maps.t["<C-'>"] = { "<Cmd>ToggleTerm<CR>", desc = "Toggle terminal" } -- requires terminal that supports binding <C-'>
        maps.i["<C-'>"] = { "<Esc><Cmd>ToggleTerm<CR>", desc = "Toggle terminl" } -- requires terminal that supports binding <C-'>

## illuminate

        maps.n["<Leader>ur"] =
          { function() require("illuminate").toggle_buf() end, desc = "Toggle reference highlighting (buffer)" }
        maps.n["<Leader>uR"] =
          { function() require("illuminate").toggle() end, desc = "Toggle reference highlighting (global)" }
