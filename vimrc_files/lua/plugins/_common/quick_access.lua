local utils = require("common-utils")
utils.keymap("n", "<c-s-r>", function()
	utils.action_menu({
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
			choice = "WIP.md",
			func = function()
				vim.cmd([[
				silent !mkdir -p .vim
				edit .vim/wip.md
			]])
			end,
		},
		{
			choice = "AGENTS.md Local",
			func = function()
				vim.cmd([[
				silent !mkdir -p .vim
				silent !touch .vim/AGENTS.md
				edit .vim/AGENTS.md
			]])
			end,
		},
		{
			choice = "MCP Setup",
			func = function()
				local path = utils.find_file_upwards(".vim/mcp.json")
				vim.cmd("silent !mkdir -p .vim")
				vim.cmd("e " .. path)
			end,
		},
		{
			choice = "MCPHub",
			func = function()
				vim.cmd("MCPHub")
			end,
		},
		{
			choice = "Direnv RC",
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
	})
end)
