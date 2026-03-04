return {
	{
		-- https://github.com/vim-test/vim-test
		"vim-test/vim-test",
		config = function()
			require("config.test").setup()
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
}
