local M = {}

function M.setup()
	require("gitsigns").setup({
		signs = {
			add = { text = "" },
			change = { text = "" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "" },
			untracked = { text = "" },
		},
		on_attach = function(bufnr)
			local utils = require("common-utils")
			local gs = require("gitsigns.actions")
			utils.buf_keymap(bufnr, "n", { "]g", "]<c-g>" }, function()
				gs.next_hunk()
			end)
			utils.buf_keymap(bufnr, "n", { "[g", "[<c-g>" }, function()
				gs.prev_hunk()
			end)
			utils.buf_keymap(bufnr, "n", { "<leader>gr" }, function()
				gs.reset_hunk()
			end)
			utils.buf_keymap(bufnr, "n", { "<leader>gd" }, function()
				vim.ui.input({ prompt = "Branch to compare (default: HEAD)" }, function(branch)
					branch = branch or "HEAD"
					gs.diffthis(branch)
				end)
			end)
		end,
		current_line_blame = true,
		current_line_blame_opts = { virt_text = true },
		current_line_blame_formatter = function(name, blame_info)
			local author = blame_info.author == name and "Me" or blame_info.author
			return {
				{ "	  ", "Normal" },
				{ "  ", "GitSignsCurrentLineBlameAccent" },
				{
					string.format("%s on %s", author, os.date("%Y-%m-%d", blame_info.author_time)),
					"GitSignsCurrentLineBlame",
				},
				{ "  ", "GitSignsCurrentLineBlameAccent" },
				{ blame_info.summary .. " ", "GitSignsCurrentLineBlame" },
			}
		end,
		current_line_blame_formatter_nc = "",
		numhl = true,
	})

	local theme = require("common-theme")
	theme.set_hl("GitSignsAdd", { fg = theme.blender.add })
	theme.set_hl("GitSignsChange", { fg = theme.blender.change })
	theme.set_hl("GitSignsDelete", { fg = theme.blender.delete })
	theme.set_hl("GitSignsTopDelete", { link = "GitSignsDelete" })
	theme.set_hl("GitSignsChangedelete", { link = "GitSignsChange" })
	theme.set_hl("GitSignsUntracked", { link = "GitSignsChange" })

	theme.set_hl("GitSignsCurrentLineBlame", { link = "Comment" })
	theme.set_hl("GitSignsCurrentLineBlameAccent", { fg = 4 })
end

return M
