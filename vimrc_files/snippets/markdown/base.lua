local M = {}

table.insert(
	M,
	s(
		{ trig = "[]", dscr = "Link" },
		fmta(
			[[
    [<>](<>)
]],
			{ v(1, "text"), i(2, "url") }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "!", dscr = "Image" },
		fmta(
			[[
    ![<>](<>)
]],
			{ v(1, "alt"), i(2, "url") }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "|(%d+)x(%d+)", dscr = "Table", regTrig = true },
		f(function(_, snip)
			local w, h = unpack(snip.captures)
			if not tonumber(w) or not tonumber(h) then
				return
			end
			local res = {}

			-- Template
			local row = {}
			for _ = 0, w do
				table.insert(row, "|")
			end
			local row_text = table.concat(row, "   ")

			-- Format
			table.insert(res, row_text)
			table.insert(res, table.concat(row, "---"))
			for _ = 1, h do
				table.insert(res, row_text)
			end
			return res
		end)
	)
)
-- (\\d+)(?:x|X)(\\d+)

return M
-- vim: noet
