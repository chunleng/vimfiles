local M = {}

table.insert(
	M,
	s(
		{ trig = "?date", dscr = "Insert current date" },
		fmta(
			[[
	<>
]],
			{ f(function()
				return os.date("%Y-%m-%d")
			end) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "?time", dscr = "Insert current time" },
		fmta(
			[[
	<>
]],
			{ f(function()
				return os.date("%X")
			end) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "?time/unix", dscr = "Insert current time in Unix Timestamp" },
		fmta(
			[[
	<>
]],
			{ f(function()
				return os.time()
			end) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "?time/unix_nano", dscr = "Insert current time in Unix Timestamp with 0-padded nanoseconds" },
		fmta(
			[[
	<>
]],
			{ f(function()
				return tostring(os.time()) .. "000000000"
			end) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "?datetime", dscr = "Insert current datetime" },
		fmta(
			[[
	<>
]],
			{ f(function()
				return os.date("%Y-%m-%d %X")
			end) }
		)
	)
)

table.insert(
	M,
	s(
		{
			trig = "?folder_tree",
			dscr = "Create a starter for folder tree",
		},
		fmta(
			[[
	.
	├─ folder
	│  ├─ a.sh
	│  └─ b.py
	└─ README.md
]],
			{}
		)
	)
)

local function comment_single_char_or_none()
	local commentstring = vim.api.nvim_eval("&commentstring")

	if commentstring:match("%%s$") and #commentstring == 4 then
		return string.sub(commentstring, 1, 1)
	end

	return nil
end

table.insert(
	M,
	s(
		{
			trig = "?comment_box",
			dscr = "Create a nice box with the current comment symbol",
		},
		fmta(
			[[
	<><><>
]],
			{
				d(2, function(args)
					local c = comment_single_char_or_none()
					local text = args[1][1] or ""
					return sn(nil, c and t({ string.rep(c, #text + 4), c .. " " }) or {})
				end, { 1 }),
				v(1),
				d(3, function(args)
					local c = comment_single_char_or_none()
					local text = args[1][1] or ""
					return sn(nil, c and t({ " " .. c, string.rep(c, #text + 4) }) or {})
				end, { 1 }),
			}
		)
	)
)

table.insert(
	M,
	s(
		{
			trig = "?comment_box_full",
			dscr = "Create a nice box with fix width",
		},
		fmta(
			[[
	<><><>
]],
			{
				-- TODO Make fix width
				d(2, function(args)
					local c = comment_single_char_or_none()
					local text = args[1][1] or ""
					return sn(nil, t({ string.rep(c, #text + 4), c .. " " }))
				end, { 1 }),
				v(1),
				d(3, function(args)
					local c = comment_single_char_or_none()
					local text = args[1][1] or ""
					return sn(nil, t({ " " .. c, string.rep(c, #text + 4) }))
				end, { 1 }),
			}
		)
	)
)

return M
-- vim: noet
