local function setup_nvim_tree()
	local api = require("nvim-tree.api")
	require("nvim-tree").setup({
		disable_netrw = false,
		hijack_cursor = true,
		diagnostics = {
			enable = true,
			icons = { hint = "", info = "", warning = "", error = "" },
		},
		view = { width = 30 },
		filters = {
			custom = { "^\\.git$", "__pycache__" },
			git_ignored = true,
		},
		actions = {
			open_file = {
				quit_on_open = true,
				window_picker = {
					enable = true,
					chars = "aoeuhtns",
					exclude = {
						filetype = {
							"notify",
							"packer",
							"qf",
							"Trouble",
							"aerial",
						},
					},
				},
				resize_window = true,
			},
			remove_file = { close_window = false },
		},
		renderer = {
			group_empty = true,
			highlight_git = false,
			root_folder_label = false,
			icons = {
				glyphs = {
					git = {
						unstaged = "● ",
						deleted = "✖ ",
						staged = " ",
						unmerged = " ",
						renamed = " ",
						untracked = " ",
						ignored = "◌ ",
					},
				},
				git_placement = "signcolumn",
			},
		},
		on_attach = function(bufnr)
			local utils = require("common-utils")
			utils.buf_keymap(bufnr, "n", "a", api.fs.create)
			utils.buf_keymap(bufnr, "n", { "<cr>", "e" }, api.node.open.edit)
			-- TODO handle node.type == 'link'
			utils.buf_keymap(bufnr, "n", "l", function()
				local node = api.tree.get_node_under_cursor()
				if node.type == "file" then
					api.node.open.preview()
				else
					if not node.open then
						api.node.open.edit()
					end
					-- Goto child
					-- TODO The following goes to the next folder when child is empty
					vim.api.nvim_feedkeys("j", "n", false)
				end
			end)
			utils.buf_keymap(bufnr, "n", "h", function()
				local node = api.tree.get_node_under_cursor()
				if node.type == "directory" and node.open then
					api.node.open.edit()
				else
					api.node.navigate.parent_close()
				end
			end)
			utils.buf_keymap(bufnr, "n", "J", api.node.navigate.sibling.next)
			utils.buf_keymap(bufnr, "n", "K", api.node.navigate.sibling.prev)
			utils.buf_keymap(bufnr, "n", "dd", api.fs.cut)
			utils.buf_keymap(bufnr, "n", "yy", api.fs.copy.node)
			utils.buf_keymap(bufnr, "n", "p", api.fs.paste)
			utils.buf_keymap(bufnr, "n", "x", api.fs.remove)
			utils.buf_keymap(bufnr, "n", "r", api.fs.rename)
			utils.buf_keymap(bufnr, "n", "R", api.tree.reload)
			utils.buf_keymap(bufnr, "n", { "q", "<c-s-enter>" }, api.tree.close)
			utils.buf_keymap(bufnr, "n", "zh", function()
				api.tree.toggle_gitignore_filter()
				api.tree.toggle_custom_filter()
			end)
			utils.buf_keymap(bufnr, "n", "gp", api.node.navigate.parent)
			utils.buf_keymap(bufnr, "n", ">>", "10<c-w>>")
			utils.buf_keymap(bufnr, "n", "<<", "10<c-w><")
		end,
	})

	local theme = require("common-theme")
	theme.set_hl("NvimTreeGitDeleted", { fg = theme.blender.delete })
	theme.set_hl("NvimTreeGitDirty", { fg = theme.blender.change })
	theme.set_hl("NvimTreeGitIgnored", { fg = theme.blender.bg_lighter_3 })
	theme.set_hl("NvimTreeGitMerge", { fg = 6 })
	theme.set_hl("NvimTreeGitNew", { fg = theme.blender.add })
	theme.set_hl("NvimTreeGitRenamed", { fg = theme.blender.change })
	theme.set_hl("NvimTreeGitStaged", { fg = 6 })
	theme.set_hl("NvimTreeFolderIcon", { link = "Directory" })
	theme.set_hl("NvimTreeExecFile", { fg = 2, bold = true })
	theme.set_hl("NvimTreeSymlink", { fg = 6, bold = true })
	theme.set_hl("NvimTreeEndOfBuffer", { bg = 0 })

	local events = api.events
	events.subscribe(events.Event.TreeOpen, function()
		vim.opt_local.cursorline = true
	end)
end

local function setup_galaxyline()
	local gl = require("galaxyline")
	local condition = require("galaxyline.condition")
	local navic = require("nvim-navic")
	local gls = gl.section
	local theme = require("common-theme")
	local utils = require("common-utils")
	local count_diagnostic = function(type)
		return #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity[type] })
	end

	navic.setup({ lsp = { auto_attach = true }, icons = utils.kind_icons })

	-- theme.set_hl(name, options)
	theme.set_hl("GalaxylineDiagnosticError", { fg = 0, bg = theme.blender.error })
	theme.set_hl("GalaxylineDiagnosticWarn", { fg = 0, bg = theme.blender.warn })
	theme.set_hl("GalaxylineGit", {
		fg = theme.blender.bg_lighter_3,
		bg = theme.blender.bg_lighter_1,
	})
	theme.set_hl("GalaxylineLineInfo", {
		fg = theme.blender.fg_darker_3,
		bg = theme.blender.bg_lighter_1,
	})
	theme.set_hl("GalaxylineFileFormat", {
		fg = theme.blender.bg_lighter_3,
		bg = theme.blender.bg_lighter_1,
	})

	gls.left = {
		{
			Space = {
				provider = function()
					return nil
				end,
				separator = " ",
				separator_highlight = "StatusLine",
			},
		},
		{
			LspError = {
				provider = function()
					return string.format("  %s ", tostring(count_diagnostic("ERROR")))
				end,
				highlight = "GalaxylineDiagnosticError",
				separator = " ",
				separator_highlight = "StatusLine",
				condition = function()
					return count_diagnostic("ERROR") > 0
				end,
			},
		},
		{
			LspWarn = {
				provider = function()
					return string.format("  %s ", tostring(count_diagnostic("WARN")))
				end,
				highlight = "GalaxylineDiagnosticWarn",
				separator = " ",
				separator_highlight = "StatusLine",
				condition = function()
					return count_diagnostic("WARN") > 0
				end,
			},
		},
		{
			nvimNavic = {
				provider = function()
					return navic.get_location()
				end,
				condition = function()
					return navic.is_available()
				end,
				highlight = "StatusLine",
			},
		},
	}

	gls.right = {
		{
			LineColumn = {
				provider = function()
					return string.format("%2d/%d  %-2d", vim.fn.line("."), vim.fn.line("$"), vim.fn.col("."))
				end,
				highlight = "GalaxylineLineInfo",
			},
		},
		{
			FileType = {
				provider = function()
					return vim.o.filetype
				end,
				condition = condition.hide_in_width,
				separator = " ",
				separator_highlight = "StatusLine",
				highlight = "GalaxylineFileFormat",
			},
		},
		{
			FileEncode = {
				provider = "FileEncode",
				condition = condition.hide_in_width,
				separator = " ",
				separator_highlight = "StatusLine",
				highlight = "GalaxylineFileFormat",
			},
		},
		{
			FileFormat = {
				provider = "FileFormat",
				condition = condition.hide_in_width,
				separator = " ",
				separator_highlight = "StatusLine",
				highlight = "GalaxylineFileFormat",
			},
		},
		{
			GitBranch = {
				provider = "GitBranch",
				condition = condition.check_git_workspace,
				icon = " ",
				separator = " ",
				separator_highlight = "StatusLine",
				highlight = "GalaxylineGit",
			},
		},
		{
			Space = {
				provider = function()
					return nil
				end,
				separator = " ",
				separator_highlight = "StatusLine",
			},
		},
	}
end

return {
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
		config = setup_nvim_tree,
		keys = {
			{ "<c-s-enter>", "<cmd>NvimTreeFindFile|NvimTreeOpen<cr>", mode = "n" },
		},
	},
	{
		-- https://github.com/glepnir/galaxyline.nvim
		-- https://github.com/SmiteshP/nvim-navic
		"glepnir/galaxyline.nvim",
		dependencies = { "SmiteshP/nvim-navic" },
		config = setup_galaxyline,
	},
}
