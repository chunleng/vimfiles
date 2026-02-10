local personal_project = "~/workspace-bootstrap/git/chunleng/"

return {
	{
		-- https://github.com/vim-test/vim-test
		"vim-test/vim-test",
		config = function()
			require("config.test").setup()
		end,
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
		"williamboman/mason.nvim",
		name = "lsp",
		version = "*",
		dependencies = {
			{ "neovim/nvim-lspconfig", version = "*" },
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
		-- https://github.com/L3MON4D3/LuaSnip
		-- https://github.com/Kaiser-Yang/blink-cmp-avante
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
					default = { "avante", "snippets", "lsp", "path", "buffer" },
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
						avante = { name = "Avante", module = "blink-cmp-avante" },
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
		dependencies = { "kristijanhusak/vim-dadbod-completion", "L3MON4D3/LuaSnip", "Kaiser-Yang/blink-cmp-avante" },
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
		-- https://github.com/yetone/avante.nvim
		dir = vim.fn.stdpath("config") .. "/lua/lazy/resolve_rc_menu/",
		name = "resolve_rc_menu",
		dependencies = { "L3MON4D3/LuaSnip", "embear/vim-localvimrc", "yetone/avante.nvim" },
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
							silent !pushd .vim && asdf set stylua 2.1.0 && popd
							edit .vim/local.lua
						]])
						end,
					},
					{
						choice = "Avante.md",
						func = function()
							vim.cmd([[
							silent !mkdir -p .vim
							silent !touch .vim/avante.md
							silent !ln -sn .vim/avante.md avante.md
							silent !ln -sn .vim/avante.md CLAUDE.local.md
							edit ./avante.md
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
		-- https://github.com/nvim-treesitter/nvim-treesitter-context
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("config.treesitter-context").setup()
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
						local line_sub = line:gsub([[%(#set! conceal_lines ""%)]], "")
						line_sub = line_sub:gsub([[%(#set! conceal ""%)]], "")
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
		-- https://github.com/zk-org/zk-nvim
		"zk-org/zk-nvim",
	},
	{
		-- https://github.com/mistweaverco/kulala.nvim/
		"mistweaverco/kulala.nvim",
		version = "*",
		config = function()
			local utils = require("common-utils")
			local kulala = require("kulala")
			kulala.setup({
				ui = {
					default_view = "headers_body",
					default_winbar_panes = { "body", "headers_body", "stats" },
					winbar = true,
					show_icons = nil,
				},
			})
			local group_name = "lKulala"
			vim.api.nvim_create_augroup(group_name, { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "http",
				callback = function(opt)
					utils.buf_keymap(opt.buf, { "n", "i" }, "<c-enter>", function()
						kulala.run()
					end)
					utils.buf_keymap(opt.buf, { "n", "i" }, "<s-enter>", function()
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
		-- https://github.com/danymat/neogen
		-- https://github.com/zk-org/zk-nvim
		dir = vim.fn.stdpath("config") .. "/lua/lazy/resolve_c_space/",
		name = "resolve_c_space",
		dependencies = { "danymat/neogen", "zk-org/zk-nvim", "yetone/avante.nvim" },
		config = function()
			require("config.c-space-completion").setup()
		end,
	},
	{
		-- https://github.com/yetone/avante.nvim
		-- https://github.com/nvim-lua/plenary.nvim
		-- https://github.com/MunifTanjim/nui.nvim
		-- https://github.com/nvim-tree/nvim-web-devicons
		-- https://github.com/stevearc/dressing.nvim
		"yetone/avante.nvim",
		event = "VeryLazy",
		build = "make",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			"stevearc/dressing.nvim",
		},
		config = function()
			require("config.avante").setup()
		end,
	},
	{
		-- https://github.com/ravitemer/mcphub.nvim
		-- https://github.com/nvim-lua/plenary.nvim
		{
			"ravitemer/mcphub.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			version = "*",
			build = function(plugin)
				local orig_nodejs_version = os.getenv("ASDF_NODEJS_VERSION")
				vim.env.ASDF_NODEJS_VERSION = require("constant").NODEJS_VERSION
				-- Replacing the recommended command with following
				--     dofile(plugin.dir .. "/bundled_build.lua")
				-- This is due to issue with version mismatch: https://github.com/ravitemer/mcphub.nvim/issues/239
				-- And it's better to control the version of package install instead of using the latest
				local bundled = plugin.dir .. "/bundled/mcp-hub"
				vim.fn.mkdir(bundled, "p")
				vim.system({ "npm", "init", "-y" }, { cwd = bundled, text = true })
				vim.system({ "npm", "install", "mcp-hub@4.2.0" }, { cwd = bundled, text = true })
				vim.env.ASDF_NODEJS_VERSION = orig_nodejs_version
			end,
			config = function(plugin)
				local constant = require("constant")
				require("mcphub").setup({
					cmd = constant.NODEJS_PATH .. "/node",
					cmdArgs = { plugin.dir .. "/bundled/mcp-hub/node_modules/mcp-hub/dist/cli.js" },
					workspace = {
						enabled = true,
						look_for = { ".mcp.json" },
					},
				})
			end,
		},
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
	{
		-- Handle folding
		-- https://github.com/kevinhwang91/nvim-ufo.git
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		config = function()
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			require("ufo").setup()
		end,
	},
}
