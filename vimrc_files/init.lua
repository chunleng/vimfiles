local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

local personal_project = "~/workspace-bootstrap/git/chunleng/"

require("lazy").setup({
	{ import = "common", priority = 99 },
	{
		-- https://github.com/nvim-tree/nvim-tree.lua
		-- https://github.com/nvim-tree/nvim-web-devicons
		-- https://github.com/nvim-treesitter/nvim-treesitter
		"nvim-tree/nvim-tree.lua",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("config.nvim-tree").setup()
		end,
	},
	{
		-- https://github.com/glepnir/galaxyline.nvim
		-- https://github.com/SmiteshP/nvim-navic
		-- https://github.com/williamboman/mason.nvim
		"glepnir/galaxyline.nvim",
		dependencies = { "SmiteshP/nvim-navic", "williamboman/mason.nvim" },
		config = function()
			require("config.cursorline").setup()
		end,
	},
	{
		-- https://github.com/akinsho/bufferline.nvim
		-- https://github.com/famiu/bufdelete.nvim
		"akinsho/bufferline.nvim",
		dependencies = { "famiu/bufdelete.nvim" },
		config = function()
			require("config.bufferline").setup()
		end,
	},
	{
		-- https://github.com/jiaoshijie/undotree
		"jiaoshijie/undotree",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
		opts = {
			window = { winblend = 10 },
		},
		keys = {
			{ "<c-s-u>", "<cmd>lua require('undotree').toggle()<cr>", mode = { "n" } },
		},
	},
	{
		-- https://github.com/AndrewRadev/linediff.vim
		"AndrewRadev/linediff.vim",
		keys = {
			{ "<leader>d", ":Linediff<cr>", mode = { "x" } },
		},
	},
	{
		-- https://github.com/tpope/vim-fugitive
		-- https://github.com/tpope/vim-rhubarb
		"tpope/vim-fugitive",
		dependencies = {
			"tpope/vim-rhubarb", -- for GBrowse
		},
		config = function()
			require("config.fugitive").setup()
		end,
	},
	{
		-- https://github.com/linrongbin16/gitlinker.nvim
		"linrongbin16/gitlinker.nvim",
		cmd = "GitLink",
		config = function()
			require("gitlinker").setup({
				router = {
					browse = {
						[".*"] = require("gitlinker.routers").github_browse,
					},
					blame = {
						[".*"] = require("gitlinker.routers").github_blame,
					},
				},
			})
		end,
		keys = {
			{ "<leader>gf", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Open git link" },
		},
	},
	{
		-- https://github.com/lewis6991/gitsigns.nvim
		-- https://github.com/nvim-lua/plenary.nvim
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config.gitsigns").setup()
		end,
	},
	{
		-- https://github.com/embear/vim-localvimrc
		"embear/vim-localvimrc",
		init = function()
			require("config.localvimrc").setup()
		end,
	},
	{
		-- https://github.com/vim-test/vim-test
		"vim-test/vim-test",
		config = function()
			require("config.test").setup()
		end,
	},
	{
		-- https://github.com/iamcco/markdown-preview.nvim
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		config = function()
			require("config.markdown-preview").setup()
		end,
		ft = { "markdown" },
	},
	{
		-- https://github.com/amiorin/vim-fenced-code-blocks
		-- https://github.com/nvim-treesitter/nvim-treesitter
		"amiorin/vim-fenced-code-blocks",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("config.fenced-code-blocks").setup()
		end,
		ft = { "markdown" },
	},
	{
		-- https://github.com/nvim-treesitter/nvim-treesitter
		"nvim-treesitter/nvim-treesitter",
		version = "*",
		config = function()
			require("config.treesitter").setup()
		end,
	},
	{
		-- https://github.com/windwp/nvim-autopairs
		-- https://github.com/nvim-treesitter/nvim-treesitter
		"windwp/nvim-autopairs",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			disable_in_macro = true,
			disable_in_visualblock = true,
			enable_afterquote = false,
			map_c_w = true,
			map_cr = false,
			check_ts = true,
		},
	},
	{
		-- https://github.com/RRethy/nvim-treesitter-endwise
		-- https://github.com/nvim-treesitter/nvim-treesitter
		"RRethy/nvim-treesitter-endwise",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{
		-- https://github.com/windwp/nvim-ts-autotag
		-- https://github.com/nvim-treesitter/nvim-treesitter
		"windwp/nvim-ts-autotag",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {},
	},
	{
		-- https://github.com/numToStr/Comment.nvim
		"numToStr/Comment.nvim",
		config = function()
			require("config.comment").setup()
		end,
	},
	{
		-- https://github.com/bronson/vim-trailing-whitespace
		"bronson/vim-trailing-whitespace",
		config = function()
			require("config.trailing-whitespace").setup()
		end,
	},
	{
		-- https://github.com/tpope/vim-surround
		"tpope/vim-surround",
	},
	{
		-- https://github.com/ibhagwan/fzf-lua
		-- https://github.com/nvim-tree/nvim-web-devicons
		-- https://github.com/nvim-treesitter/nvim-treesitter-context
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter-context", "lsp" },
		config = function()
			require("config.fzf").setup()
		end,
	},
	{
		-- https://github.com/williamboman/mason.nvim
		-- https://github.com/williamboman/mason-lspconfig
		-- https://github.com/neovim/nvim-lspconfig
		-- https://github.com/folke/neodev.nvim
		-- https://github.com/b0o/schemastore.nvim
		-- https://github.com/ibhagwan/fzf-lua
		-- https://github.com/jayp0521/mason-nvim-dap.nvim
		-- https://github.com/mfussenegger/nvim-dap
		-- https://github.com/rcarriga/nvim-dap-ui
		-- https://github.com/nvim-neotest/nvim-nio
		-- https://github.com/ofirgall/goto-breakpoints.nvim
		-- https://github.com/nvimtools/none-ls.nvim
		-- https://github.com/nvimtools/none-ls-extras.nvim
		-- https://github.com/barreiroleo/ltex_extra.nvim
		-- https://github.com/stevearc/aerial.nvim
		-- https://github.com/zapling/mason-lock.nvim
		"williamboman/mason.nvim",
		name = "lsp",
		version = "*",
		dependencies = {
			"neovim/nvim-lspconfig",
			"folke/neodev.nvim",
			"b0o/schemastore.nvim",
			"ibhagwan/fzf-lua",
			"jayp0521/mason-nvim-dap.nvim",
			"mfussenegger/nvim-dap",
			{ "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
			"ofirgall/goto-breakpoints.nvim",
			{ "nvimtools/none-ls.nvim", dependencies = { "nvimtools/none-ls-extras.nvim" } },
			"barreiroleo/ltex_extra.nvim",
			"stevearc/aerial.nvim",
			{ dir = personal_project .. "nvim-dap-kitty-launcher" },
			"zapling/mason-lock.nvim",
			"Saghen/blink.cmp",
		},
		config = function()
			require("config.lsp").setup()
		end,
	},
	{
		-- https://github.com/stevearc/aerial.nvim
		"stevearc/aerial.nvim",
		version = "*",
		config = function()
			require("config.aerial-nvim").setup()
		end,
	},
	{
		-- https://github.com/kristijanhusak/vim-dadbod-ui
		-- https://github.com/tpope/vim-dadbod
		"kristijanhusak/vim-dadbod-ui",
		dependencies = { "tpope/vim-dadbod" },
		init = function()
			require("config.dadbod-ui").beforeSetup()
		end,
		config = function()
			require("config.dadbod-ui").setup()
		end,
	},
	{
		-- https://github.com/Saghen/blink.cmp
		-- https://github.com/kristijanhusak/vim-dadbod-completion
		"Saghen/blink.cmp",
		version = "1.*",
		config = function()
			local function show_if_not_first_character(blink)
				-- Show completion menu if characters up to cursor consist of non-whitespace characters
				local _, col = unpack(vim.api.nvim_win_get_cursor(0))
				if col > 0 then
					local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
					if not before_cursor:match("^%s*$") then -- Check if all before-cursor chars are whitespace
						blink.show()
					end
				end
			end
			local blink = require("blink-cmp")
			local tailwind_color_icon = " "
			blink.setup({
				keymap = {
					preset = "none",
					["<tab>"] = {
						function(_)
							local ls = require("luasnip")
							if ls.expandable() then
								vim.schedule(function()
									ls.expand()
								end)
								return true
							end
						end,
						"accept",
						"fallback_to_mappings",
					},
					["<c-h>"] = {
						function(cmp)
							cmp.hide()
							vim.lsp.buf.signature_help()
						end,
					},
					["<c-n>"] = {
						"select_next",
						"fallback_to_mappings",
					},
					["<c-p>"] = {
						"select_prev",
						"fallback_to_mappings",
					},
					["<bs>"] = {
						show_if_not_first_character,
						"fallback_to_mappings",
					},
					["<c-;>"] = {
						function(cmp)
							cmp.show({ providers = { "snippets" } })
						end,
						"fallback_to_mappings",
					},
				},
				cmdline = {
					keymap = {
						preset = "none",
						["<tab>"] = {
							function(cmp)
								if cmp.is_ghost_text_visible() and not cmp.is_menu_visible() then
									return cmp.accept()
								end
							end,
							"show_and_insert",
							"select_next",
						},
						["<s-tab>"] = {
							function(cmp)
								if cmp.is_ghost_text_visible() and not cmp.is_menu_visible() then
									return cmp.accept()
								end
							end,
							"show_and_insert",
							"select_prev",
						},
						["<c-n>"] = { "select_next", "fallback" },
						["<c-p>"] = { "select_prev", "fallback" },
						["<c-e>"] = {
							function()
								-- On version 1.0.0, without remapping to <end>, the cursor doesn't shift properly. This
								-- block of code fixes that problem
								vim.fn.eval('feedkeys("\\<end>")')
							end,
						},
					},
				},
				snippets = { preset = "luasnip" },
				sources = {
					default = { "snippets", "lsp", "path", "buffer" },
					per_filetype = {
						sql = { "snippets", "dadbod", "buffer" },
					},
					providers = {
						dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
						lsp = {
							opts = {
								tailwind_color_icon = tailwind_color_icon,
							},
						},
					},
				},
				completion = {
					menu = {
						auto_show = true,
						draw = {
							columns = {
								{ "label", "label_description", gap = 1 },
								{ "kind_icon" },
							},
							components = {
								kind_icon = {
									text = function(ctx)
										local kind_icons = require("common-utils").kind_icons
										if ctx.kind_icon == tailwind_color_icon then
											return ctx.kind_icon
										else
											return kind_icons[ctx.kind] or kind_icons["Text"]
										end
									end,
								},
							},
						},
					},
				},
			})
			local group_name = "lBlinkInsert"
			vim.api.nvim_create_augroup(group_name, { clear = true })
			vim.api.nvim_create_autocmd("InsertEnter", {
				pattern = "*",
				callback = function()
					show_if_not_first_character(blink)
				end,
				group = group_name,
			})

			local theme = require("common-theme")
			theme.set_hl("BlinkCmpLabelMatch", { fg = 12 })
			theme.set_hl("BlinkCmpLabelDeprecated", { strikethrough = true, fg = theme.blender.fg_darker_3 })
			theme.set_hl("BlinkCmpKind", { fg = 12 })
		end,
		dependencies = { "kristijanhusak/vim-dadbod-completion", "L3MON4D3/LuaSnip" },
	},
	{
		-- https://github.com/L3MON4D3/LuaSnip
		"L3MON4D3/LuaSnip",
		config = function()
			require("config.snippets").setup()
		end,
	},
	{
		-- https://github.com/danymat/neogen
		"danymat/neogen",
		dependencies = { "L3MON4D3/LuaSnip" },
		config = function()
			require("config.neogen").setup()
		end,
	},
	{
		dir = vim.fn.stdpath("config") .. "/lua/lazy/resolve_cr/",
		name = "resolve_cr",
		config = function()
			local utils = require("common-utils")
			local ls = require("luasnip")
			local blink = require("blink-cmp")

			utils.keymap({ "i", "s" }, "<cr>", function()
				if ls.jumpable(1) then
					blink.hide()
					ls.jump(1)
				else
					local is_end_of_line = #vim.api.nvim_get_current_line() == vim.api.nvim_win_get_cursor(0)[2]
					if is_end_of_line and vim.o.filetype == "markdown" then
						vim.cmd("InsertNewBullet")
					else
						vim.fn.feedkeys(require("nvim-autopairs").autopairs_cr(), "n")
					end
				end
			end)
		end,
		dependencies = {
			"windwp/nvim-autopairs",
			"L3MON4D3/LuaSnip",
			"dkarter/bullets.vim",
			"Saghen/blink.cmp",
		},
	},
	{
		-- https://github.com/L3MON4D3/LuaSnip
		-- https://github.com/embear/vim-localvimrc
		dir = vim.fn.stdpath("config") .. "/lua/lazy/resolve_rc_menu/",
		name = "resolve_rc_menu",
		dependencies = { "L3MON4D3/LuaSnip", "embear/vim-localvimrc" },
		config = function()
			local utils = require("common-utils")
			utils.keymap("n", "<c-s-r>", function()
				utils.action_menu({
					{
						choice = "Vim RC",
						func = function()
							vim.cmd("edit ~/.config/nvim/init.lua")
						end,
					},
					{
						choice = "Vim Local RC",
						func = function()
							vim.cmd([[
                            silent !mkdir -p .vim
                            edit .vim/local.lua
                        ]])
						end,
					},
					{
						choice = "Direnvrc",
						func = function()
							vim.cmd("edit .envrc")
						end,
					},
					{
						choice = "LuaSnip",
						func = function()
							require("luasnip.loaders").edit_snippet_files()
						end,
					},
					{
						choice = "Zsh",
						func = function()
							vim.cmd("edit ~/.zshrc")
						end,
					},
					{
						choice = "Hammerspoon",
						func = function()
							vim.cmd("edit ~/.hammerspoon/init.lua")
						end,
					},
					{
						choice = "Kitty",
						func = function()
							vim.cmd("edit ~/.config/kitty/kitty.conf")
						end,
					},
				})
			end)
		end,
	},
	{
		-- https://github.com/petertriho/nvim-scrollbar
		"petertriho/nvim-scrollbar",
		dependencies = { "Saghen/blink.cmp" },
		config = function()
			require("config.nvim-scrollbar").setup()
		end,
	},
	{
		-- https://github.com/nvim-treesitter/playground
		-- https://github.com/nvim-treesitter/nvim-treesitter
		"nvim-treesitter/playground",
		cmd = "TSPlaygroundToggle",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{
		-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
		-- https://github.com/nvim-treesitter/nvim-treesitter
		"JoosepAlviste/nvim-ts-context-commentstring",
		dependencies = "nvim-treesitter/nvim-treesitter",
		opts = {},
	},
	{
		-- https://github.com/tpope/vim-sleuth
		-- https://github.com/Yggdroot/indentLine
		"Yggdroot/indentLine",
		dependencies = { "tpope/vim-sleuth" },
		config = function()
			require("config.indent").setup()
		end,
	},
	{
		-- https://github.com/aklt/plantuml-syntax
		"aklt/plantuml-syntax",
		ft = { "plantuml" },
	},
	{
		-- https://github.com/NvChad/nvim-colorizer.lua
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("config.colorizer").setup()
		end,
	},
	{
		-- https://github.com/stevearc/dressing.nvim
		"stevearc/dressing.nvim",
		config = function()
			require("config.dressing").setup()
		end,
	},
	{
		-- https://github.com/dkarter/bullets.vim
		"dkarter/bullets.vim",
		init = function()
			require("config.bullets").setup()
		end,
	},
	{
		-- https://github.com/nvim-treesitter/nvim-treesitter-context
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("config.treesitter-context").setup()
		end,
	},
	{
		-- https://github.com/Robitx/gp.nvim
		"Robitx/gp.nvim",
		config = function()
			require("config.ai").setup()
		end,
	},
	{
		-- https://github.com/tpope/vim-projectionist
		"tpope/vim-projectionist",
		config = function()
			require("config.projectionist").setup()
		end,
	},
	{
		-- https://github.com/nvim-treesitter/nvim-treesitter
		dir = vim.fn.stdpath("config") .. "/lua/lazy/stop_conceal/",
		name = "stop_conceal",
		config = function()
			-- Using this because there are some problems with control over conceals
			-- https://github.com/nvim-treesitter/nvim-treesitter/issues/2825

			for _, lang in ipairs({
				"json",
				"jsonc",
				"markdown",
				"markdown_inline",
			}) do
				local queries = {}
				for _, file in ipairs(require("vim.treesitter.query").get_files(lang, "highlights")) do
					for _, line in ipairs(vim.fn.readfile(file)) do
						local line_sub = line:gsub([[%(#set! conceal ""%)]], "")
						table.insert(queries, line_sub)
					end
				end
				require("vim.treesitter.query").set(lang, "highlights", table.concat(queries, "\n"))
			end
		end,
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{
		-- https://github.com/ibhagwan/fzf-lua
		dir = vim.fn.stdpath("config") .. "/lua/lazy/quick_replace/",
		name = "quick_replace",
		dependencies = { "ibhagwan/fzf-lua" },
		config = function()
			local utils = require("common-utils")

			-- Easy replace with selection
			utils.keymap("x", "<c-r>", function()
				local separator = ""
				local left_key = vim.api.nvim_replace_termcodes("<left>", true, false, true)
				-- TODO replace fzf-lua get_visual_selection function with
				-- https://github.com/neovim/neovim/issues/16843
				local feedkeys = (":%%s%s\\(%s\\)%s%sg%s%s"):format(
					separator,
					require("fzf-lua.utils").get_visual_selection(),
					separator,
					separator,
					left_key,
					left_key
				)
				vim.api.nvim_feedkeys(feedkeys, "n", false)
			end)
		end,
	},
	{
		"mg979/vim-visual-multi",
		init = function()
			vim.g.VM_default_mappings = 0
			vim.g.VM_mouse_mappings = 0
			vim.g.VM_maps = {
				["Find Under"] = "\\",
				["Find Subword Under"] = "\\",
				["Select All"] = "g\\",
			}
		end,
	},
	{
		-- A more sane gf
		-- https://github.com/nvim-tree/nvim-tree.lua
		dir = vim.fn.stdpath("config") .. "/lua/lazy/resolve_gf/",
		name = "resolve_gf",
		dependencies = { "nvim-tree/nvim-tree.lua" },
		config = function()
			local utils = require("common-utils")
			local tree_api = require("nvim-tree.api")

			-- Add on to existing feature
			utils.keymap("n", "gf", function()
				local path = vim.fn.expand("<cfile>")

				if not path:match("^/") then
					path = vim.fn.expand("%:h") .. "/" .. path
				end

				if vim.fn.filereadable(path) == 1 then
					vim.cmd(":e " .. path)
				elseif vim.fn.isdirectory(path) == 1 then
					tree_api.tree.open()
					tree_api.tree.find_file(path)
				else
					local response = vim.fn.confirm('Create "' .. path .. '"?')
					if response == 1 then
						vim.cmd(":e " .. path)
					end
				end
			end)
			-- utils.keymap("x", "gf", "<cmd>e %:h/<cword><cr>")
		end,
	},
	{
		-- https://github.com/mickael-menu/zk-nvim
		"mickael-menu/zk-nvim",
		config = function()
			require("zk").setup()
			local utils = require("common-utils")
			-- Check if folder is ZK Enabled
			if vim.fn.filereadable(".zk/notebook.db") == 0 then
				return
			end
			utils.keymap({ "n" }, "<c-s-n>", function()
				utils.action_menu({
					{
						choice = "Today's Journal",
						func = function()
							-- Get timestamp 6 hours ago (6 * 60 * 60 = 21600 seconds)
							local time_6h_ago = os.time() - 21600
							local folder = os.date("./journal/%Y/%m", time_6h_ago)
							local file = folder .. "/" .. os.date("%Y%m%d.md", time_6h_ago)
							os.execute("mkdir -p " .. folder)
							os.execute("touch " .. file)
							vim.cmd("e " .. file)
						end,
					},
					{
						choice = "Tags",
						func = function()
							vim.cmd("ZkTags")
						end,
					},
					{
						choice = "Links",
						func = function()
							vim.cmd("ZkLinks")
						end,
					},
					{
						choice = "Back Links",
						func = function()
							vim.cmd("ZkBacklinks")
						end,
					},
				})
			end)
		end,
	},
	{
		-- https://github.com/mistweaverco/kulala.nvim/
		"mistweaverco/kulala.nvim",
		version = "*",
		config = function()
			local utils = require("common-utils")
			local kulala = require("kulala")
			kulala.setup({
				default_view = "headers_body",
				default_winbar_panes = { "body", "headers_body", "stats" },
				winbar = true,
				show_icons = nil,
			})
			local group_name = "lKulala"
			vim.api.nvim_create_augroup(group_name, { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "http",
				callback = function(opt)
					utils.buf_keymap(opt.buf, { "n", "i" }, "<c-enter>", function()
						for _, buf in ipairs(vim.api.nvim_list_bufs()) do
							if vim.api.nvim_buf_get_name(buf):match("^kulala://ui$") then
								vim.api.nvim_buf_delete(buf, {})
							end
						end
						kulala.run_all()
					end)
				end,
				group = group_name,
			})
			-- Need BufEnter because somehow the buf number changes after the initial buffer creation
			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = "kulala://ui",
				callback = function(opt)
					utils.buf_keymap(opt.buf, "n", "q", function()
						vim.cmd("bd")
					end)
				end,
				group = group_name,
			})

			-- TODO format the copied curl to exclude some header and remove silence (This feature might not be
			-- available in Kulala.nvim yet
			vim.api.nvim_create_user_command("KulalaCopy", function(opts)
				local restore_env = kulala.get_selected_env()
				local env = opts.args == "" and restore_env or opts.args
				kulala.set_selected_env(env)
				kulala.copy()
				kulala.set_selected_env(restore_env)
			end, { nargs = "?" })
		end,
	},
	{
		-- Autocompletion menu
		-- https://github.com/yetone/avante.nvim
		-- https://github.com/Robitx/gp.nvim
		-- https://github.com/danymat/neogen
		-- https://github.com/mickael-menu/zk-nvim
		dir = vim.fn.stdpath("config") .. "/lua/lazy/resolve_c_space/",
		name = "resolve_c_space",
		dependencies = { "Robitx/gp.nvim", "danymat/neogen", "mickael-menu/zk-nvim", "yetone/avante.nvim" },
		config = function()
			require("config.c-space-completion").setup()
		end,
	},
	{
		-- https://github.com/yetone/avante.nvim
		-- https://github.com/nvim-lua/plenary.nvim
		-- https://github.com/MunifTanjim/nui.nvim
		-- https://github.com/hrsh7th/cmp-nvim-lsp
		-- https://github.com/nvim-tree/nvim-web-devicons
		"yetone/avante.nvim",
		version = "*",
		event = "VeryLazy",
		build = "make",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local utils = require("common-utils")
			local avante = require("avante")
			avante.setup({
				hints = { enabled = false },
				provider = "claude",
				auto_suggestions_provider = "claude_fast",
				providers = {
					claude = {
						endpoint = "https://api.anthropic.com",
						model = "claude-3-7-sonnet-latest",
						timeout = 30000, -- Timeout in milliseconds
						extra_request_body = {
							temperature = 0,
							max_tokens = 4096,
						},
					},
					claude_fast = {
						__inherited_from = "claude",
						model = "claude-3-haiku-20240307",
					},
				},
				-- Enable default mapping for now as visual selection does not work properly
				-- behaviour = {
				-- 	auto_set_keymaps = false,
				-- },
				mappings = {
					-- Using U+2800 (braille pattern blank) to void keys
					diff = {
						ours = "⠀",
						theirs = "⠀",
						all_theirs = "⠀",
						both = "⠀",
						cursor = "<c-->",
						next = "<c-.>s",
						prev = "<c-,>s",
					},
					suggestion = {
						accept = "⠀",
						next = "⠀",
						prev = "⠀",
						dismiss = "⠀",
					},
					jump = {
						next = "<c-.>s",
						prev = "<c-,>s",
					},
					submit = {
						normal = "<c-cr>",
						insert = "<c-cr>",
					},
					sidebar = {
						apply_all = "⠀",
						apply_cursor = "<c-->",
						switch_windows = "⠀",
						reverse_switch_windows = "⠀",
					},
				},
			})
			local group_name = "lAvante"
			vim.api.nvim_create_augroup(group_name, { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "Avante*",
				callback = function(opt)
					utils.buf_keymap(opt.buf, "n", "q", function()
						avante.toggle_sidebar()
					end)
				end,
				group = group_name,
			})
		end,
	},
	{
		-- https://github.com/rayliwell/tree-sitter-rstml
		"rayliwell/tree-sitter-rstml",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		version = "*",
		build = ":TSInstall rust_with_rstml",
		config = function()
			require("tree-sitter-rstml").setup()
		end,
	},
	{
		-- https://github.com/tiagovla/scope.nvim
		"tiagovla/scope.nvim",
		config = true,
	},
})
