local M = {}

local ls = require("luasnip")
local types = require("luasnip.util.types")

local s = require("luasnip.nodes.snippet").S
local sn = require("luasnip.nodes.snippet").SN
local isn = require("luasnip.nodes.snippet").ISN
local t = require("luasnip.nodes.textNode").T
local i = require("luasnip.nodes.insertNode").I
local f = require("luasnip.nodes.functionNode").F
local c = require("luasnip.nodes.choiceNode").C
local d = require("luasnip.nodes.dynamicNode").D
local r = require("luasnip.nodes.restoreNode").R
local l = require("luasnip.extras").lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local parse = require("luasnip.util.parser").parse_snippet

local theme = require("common-theme")
local utils = require("common-utils")

function M.setup()
	theme.set_hl("LuaSnipSnippetPassive", { fg = 15 })
	theme.set_hl("LuaSnipInsertNodeActiveVirtual", { bold = true, fg = 0, bg = 11 })
	theme.set_hl("LuaSnipInsertNodePassive", { fg = 3, underdotted = true })
	theme.set_hl("LuaSnipInsertNodeActive", { fg = 11 })
	theme.set_hl("LuaSnipChoiceNodeActive", { link = "Visual" })

	ls.setup({
		update_events = "TextChanged,TextChangedI",
		store_selection_keys = "<tab>",
		-- ref: https://github.com/L3MON4D3/LuaSnip/blob/master/lua/luasnip/config.lua#L122-L147
		snip_env = {
			s = s,
			sn = sn,
			isn = isn,
			t = t,
			i = i,
			f = f,
			c = c,
			d = d,
			r = r,
			l = l,
			fmt = fmt,
			fmta = fmta,
			parse = parse,
			-- customized
			v = function(jump_index, default_text, editable)
				editable = editable and editable or false

				return d(jump_index, function(_, snip)
					local visual = snip.env and snip.env.LS_SELECT_RAW or snip.snippet.env.LS_SELECT_RAW
					return sn(nil, {
						#visual == 0 and i(1, default_text) or (editable and i(1, visual) or t(visual)),
					})
				end)
			end,
		},
		ext_opts = {
			[types.snippet] = {
				passive = {
					hl_group = "LuaSnipSnippetPassive",
					virt_text = { { " ‥ ", "LuaSnipInsertNodeActiveVirtual" } },
				},
			},
			[types.insertNode] = {
				active = { hl_group = "LuaSnipInsertNodeActive", priority = 2 },
				passive = { hl_group = "LuaSnipInsertNodePassive", priority = 2 },
			},
			[types.choiceNode] = {
				active = { hl_group = "LuaSnipChoiceNodeActive", priority = 1 },
			},
		},
	})
	ls.filetype_extend("bash", { "sh" })
	ls.filetype_extend("javascriptreact", { "javascript" })
	ls.filetype_extend("typescript", { "javascript" })
	ls.filetype_extend("typescriptreact", { "javascriptreact", "typescript", "javascript" })

	require("luasnip.loaders").cleanup()
	require("luasnip.loaders.from_lua").load({
		paths = "~/.config/nvim/snippets/",
	})

	utils.keymap("i", "<tab>", function()
		if ls.expandable() then
			ls.expand()
		else
			vim.api.nvim_eval([[feedkeys("\<tab>", "n")]])
		end
	end)
	utils.keymap({ "i", "s" }, "<esc>", function()
		if ls.jumpable(1) then
			ls.jump(1)
			if not ls.jumpable(1) then
				vim.api.nvim_eval([[feedkeys("\<esc>", "n")]])
			end
		else
			vim.api.nvim_eval([[feedkeys("\<esc>", "n")]])
		end
	end)
	utils.keymap({ "s", "x", "i" }, "<c-enter>", function()
		if ls.choice_active() then
			ls.change_choice(1)
		end
	end)

	-- Go into normal mode when deleting select to improve completion flow
	utils.keymap({ "s" }, "<bs>", "<bs>i")
end

return M
