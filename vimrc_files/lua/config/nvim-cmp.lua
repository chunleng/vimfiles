local M = {}

local function get_tailwind_cmp_hl_group(entry, vim_item)
	-- Reference from
	-- https://github.com/roobert/tailwindcss-colorizer-cmp.nvim/blob/09fbf6dfd85ecae5e45b9200b37a79fc87e1fc40/lua/tailwindcss-colorizer-cmp/init.lua#L82
	if vim.tbl_contains({ "nvim_lsp" }, entry.source.name) and vim_item.kind == "Color" then
		local words = {}
		for word in string.gmatch(vim_item.word, "[^-]+") do
			table.insert(words, word)
		end

		if #words < 3 or #words > 4 then
			return nil
		end

		local color_name, color_number
		if
			words[2] == "x"
			or words[2] == "y"
			or words[2] == "t"
			or words[2] == "b"
			or words[2] == "l"
			or words[2] == "r"
		then
			color_name = words[3]
			color_number = words[4]
		else
			color_name = words[2]
			color_number = words[3]
		end

		if not color_name or not color_number then
			return nil
		end

		local color_index = tonumber(color_number)
		local tailwindcss_colors = require("tailwindcss-colorizer-cmp.colors").TailwindcssColors

		local color = vim.tbl_get(tailwindcss_colors, color_name, color_index)
		if color == nil then
			return nil
		end

		local hl_group = "lsp_documentColor_mf_" .. color
		vim.api.nvim_set_hl(0, hl_group, { fg = "#" .. color, bg = "#" .. color })
		return hl_group
	end
end

function M.setup()
	local cmp = require("cmp")
	local compare = require("cmp.config.compare")
	local kind_icons = require("common-utils").kind_icons
	local tailwindcss_cmp = require("tailwindcss-colorizer-cmp")

	tailwindcss_cmp.setup()
	cmp.setup({
		-- Since I my sorting prioritize exact elements first, preselect is not required
		preselect = require("cmp.types").cmp.PreselectMode.None,
		window = {
			completion = cmp.config.window.bordered({
				border = "none",
				winhighlight = "Normal:Pmenu,CursorLine:PmenuSel",
			}),
			documentation = cmp.config.window.bordered({
				winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
			}),
		},
		formatting = {
			format = function(entry, vim_item)
				local tw_hl_group = get_tailwind_cmp_hl_group(entry, vim_item)
				vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind

				if tw_hl_group then
					vim_item.menu_hl_group = tw_hl_group
					vim_item.menu = string.format("  ")
				else
					-- Source
					vim_item.menu = ({
						path = "",
						luasnip = "",
						nvim_lsp = " LSP",
						buffer = " Buffer",
						["vim-dadbod-completion"] = " DB",
					})[entry.source.name]
				end
				return vim_item
			end,
		},
		sorting = {
			comparators = {
				function(entry1, entry2)
					-- Exact that is snippet
					local worthy_exact1 = entry1.exact
						and (entry1.completion_item.insertText ~= nil or entry1.completion_item.textEdit ~= nil)
					local worthy_exact2 = entry2.exact
						and (entry2.completion_item.insertText ~= nil or entry2.completion_item.textEdit ~= nil)
					if worthy_exact1 ~= worthy_exact2 then
						return worthy_exact1
					end
				end,
				compare.recently_used,
				function(entry1, entry2)
					-- Custom sorting that prioritize via a combination of the following criteria
					-- * Not exact (leave it to exact sorting)
					-- * Less fuzziness (higher score)
					-- * Snippet first
					local score1 = entry1.exact and 0
						or (
							entry1.score
							+ (
								(entry1.completion_item.insertText ~= nil or entry1.completion_item.textEdit ~= nil)
									and 1
								or 0
							)
						)
					local score2 = entry2.exact and 0
						or (
							entry2.score
							+ (
								(entry2.completion_item.insertText ~= nil or entry2.completion_item.textEdit ~= nil)
									and 1
								or 0
							)
						)
					local diff = score2 - score1
					if diff < 0 then
						return true
					elseif diff > 0 then
						return false
					end
				end,
				compare.sort_text,
			},
		},
		sources = {
			{ name = "path", priority = 100 },
			{ name = "luasnip", priority = 35 },
			{ name = "nvim_lsp", max_item_count = 99999, priority = 30 },
			{ name = "vim-dadbod-completion", priority = 30 },
			{
				name = "buffer",
				max_item_count = 10,
				priority = 1,
				option = {
					-- https://github.com/hrsh7th/cmp-buffer#visible-buffers
					get_bufnrs = function()
						local bufs = {}
						for _, win in ipairs(vim.api.nvim_list_wins()) do
							-- TODO https://github.com/hrsh7th/cmp-buffer#performance-on-large-text-files
							bufs[vim.api.nvim_win_get_buf(win)] = true
						end
						return vim.tbl_keys(bufs)
					end,
				},
			},
		},
		mapping = cmp.mapping.preset.insert({
			["<tab>"] = cmp.mapping(function(fallback)
				local ls = require("luasnip")
				if ls.expandable() then
					ls.expand_or_jump()
				elseif cmp.visible() then
					cmp.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					})
				else
					fallback()
				end
			end, { "i", "s" }),
			["<c-e>"] = cmp.mapping(function(fallback)
				fallback()
			end),
			["<s-down>"] = cmp.mapping.scroll_docs(4),
			["<s-up>"] = cmp.mapping.scroll_docs(-4),
		}),
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		completion = {
			autocomplete = {
				cmp.TriggerEvent.TextChanged,
				cmp.TriggerEvent.InsertEnter,
			},
		},
	})

	local theme = require("common-theme")
	theme.set_hl("CmpItemAbbrMatch", { fg = 12 })
	theme.set_hl("CmpItemAbbrMatchFuzzy", { fg = 12 })
	theme.set_hl("CmpItemAbbrDeprecatedDefault", { strikethrough = true, fg = theme.blender.fg_darker_3 })
	theme.set_hl("CmpItemMenu", { italic = true, fg = theme.blender.fg_lighter_2 })
	theme.set_hl("CmpItemKind", { fg = 12 })
	theme.set_hl("CmpItemKind", { fg = 12 })
end

return M
