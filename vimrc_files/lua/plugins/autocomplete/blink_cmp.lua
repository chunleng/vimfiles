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

local function setup()
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
end

return {
	{
		-- https://github.com/Saghen/blink.cmp
		-- https://github.com/kristijanhusak/vim-dadbod-completion
		"Saghen/blink.cmp",
		version = "1.*",
		config = setup,
		dependencies = { "kristijanhusak/vim-dadbod-completion" },
	},
}
