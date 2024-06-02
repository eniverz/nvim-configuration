return {
	"nvim-treesitter/nvim-treesitter",
	lazy = true,
	build = function()
		if #vim.api.nvim_list_uis() ~= 0 then
			vim.api.nvim_command([[TSUpdate]])
		end
	end,
	event = "BufReadPre",
	dependencies = {
		{ "andymass/vim-matchup" },
		{ "mfussenegger/nvim-treehopper" },
		{ "nvim-treesitter/nvim-treesitter-textobjects" },
		{
			"abecodes/tabout.nvim",
			opts = {
				tabkey = "", -- key to trigger tabout, set to an empty string to disable
				backwards_tabkey = "", -- key to trigger backwards tabout, set to an empty string to disable
				act_as_tab = true, -- shift content if tab out is not possible
				act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
				enable_backwards = true,
				completion = true, -- if the tabkey is used in a completion pum
				tabouts = {
					{ open = "'", close = "'" },
					{ open = '"', close = '"' },
					{ open = "`", close = "`" },
					{ open = "(", close = ")" },
					{ open = "[", close = "]" },
					{ open = "{", close = "}" },
				},
				ignore_beginning = true, -- if the cursor is at the beginning of a filled element it will rather tab out than shift the content
				exclude = {}, -- tabout will ignore these filetypes
			},
			config = function(_, opts)
				require("tabout").setup(opts)
			end,
		},
		{
			"windwp/nvim-ts-autotag",
			opts = {
				filetypes = {
					"html",
					"javascript",
					"javascriptreact",
					"typescriptreact",
					"vue",
					"xml",
				},
			},
			config = function(...)
				require("plugins.config.ts-autotag")(...)
			end,
		},
		{
			-- TODO: replace with nvim-highlight-colors: https://github.com/brenoprata10/nvim-highlight-colors
			"NvChad/nvim-colorizer.lua",
			cmd = {
				"ColorizerToggle",
				"ColorizerAttachToBuffer",
				"ColorizerDetachFromBuffer",
				"ColorizerReloadAllBuffers",
			},
			config = function(_, opts)
				require("colorizer").setup(opts)
			end,
		},
		{
			"hiphish/rainbow-delimiters.nvim",
			config = function()
				---@param threshold number @Use global strategy if nr of lines exceeds this value
				local function init_strategy(threshold)
					return function()
						local errors = 200
						vim.treesitter.get_parser():for_each_tree(function(lt)
							if lt:root():has_error() and errors >= 0 then
								errors = errors - 1
							end
						end)
						if errors < 0 then
							return nil
						end
						return vim.fn.line("$") > threshold and require("rainbow-delimiters").strategy["global"]
							or require("rainbow-delimiters").strategy["local"]
					end
				end

				vim.g.rainbow_delimiters = {
					strategy = {
						[""] = init_strategy(500),
						c = init_strategy(200),
						cpp = init_strategy(200),
						lua = init_strategy(500),
						vimdoc = init_strategy(300),
						vim = init_strategy(300),
					},
					query = {
						[""] = "rainbow-delimiters",
						latex = "rainbow-blocks",
						javascript = "rainbow-delimiters-react",
					},
					highlight = {
						"RainbowDelimiterRed",
						"RainbowDelimiterOrange",
						"RainbowDelimiterYellow",
						"RainbowDelimiterGreen",
						"RainbowDelimiterBlue",
						"RainbowDelimiterCyan",
						"RainbowDelimiterViolet",
					},
				}
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter-context",
			opts = {
				enable = true,
				max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				zindex = 30,
			},
			config = function(_, opts)
				require("treesitter-context").setup(opts)
			end,
		},
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			lazy = true,
			init = function()
				if vim.fn.has("nvim-0.10") == 1 then
					-- HACK: add workaround for native comments: https://github.com/JoosepAlviste/nvim-ts-context-commentstring/issues/109
					vim.schedule(function()
						local get_option = vim.filetype.get_option
						local context_commentstring
						vim.filetype.get_option = function(filetype, option)
							if option ~= "commentstring" then
								return get_option(filetype, option)
							end
							if context_commentstring == nil then
								local ts_context_avail, ts_context = pcall(require, "ts_context_commentstring.internal")
								context_commentstring = ts_context_avail and ts_context
							end
							return context_commentstring and context_commentstring.calculate_commentstring()
								or get_option(filetype, option)
						end
					end)
				end
			end,
			opts = { enable_autocmd = false },
			config = function(_, opts)
				require("ts_context_commentstring").setup(opts)
			end,
		},
	},
	config = require("plugins.config.treesitter"),
}
