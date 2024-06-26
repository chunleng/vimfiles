local M = {}

table.insert(
	M,
	s(
		{ trig = "imp", dscr = "Import" },
		fmta(
			[[
	local <> = require('<>')
]],
			{ i(1, "mod"), i(2, "modname") }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "f", dscr = "Function" },
		fmta(
			[[
	function <>(<>)
		<>
	end
]],
			{ i(1, "func_a"), i(2, "var_a"), i(0) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "fx", dscr = "Lambda Function" },
		fmta(
			[[
	function(<>) <> end
]],
			{ i(1, "var_a"), i(0) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "?", dscr = "Ternary-if" },
		fmta(
			[[
	<> and <> or <>
]],
			{ i(1, 'foo_a == "bar"'), i(2, "'a'"), i(3, "'b'") }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "i", dscr = "If" },
		fmta(
			[[
	if <> then
		<>
	end
]],
			{ i(1), i(0) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "e", dscr = "Else" },
		fmta(
			[[
	else
		<>
]],
			{ i(0) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "ei", dscr = "Else-if" },
		fmta(
			[[
	elseif <> then
		<>
]],
			{ i(1), i(0) }
		)
	)
)

table.insert(M, s({ trig = "o", dscr = "Short-circuit or" }, t("or ")))
table.insert(M, s({ trig = "a", dscr = "Short-circuit and" }, t("and ")))
table.insert(M, s({ trig = "n", dscr = "Boolean not" }, t("not ")))
table.insert(M, s({ trig = "ne", dscr = "Not equal" }, t("~= ")))

table.insert(
	M,
	s(
		{ trig = "l", dscr = "Loop (for)" },
		fmta(
			[[
	for <> do
		<>
	end
]],
			{
				c(1, {
					fmta("<>, <> in ipairs(<>)", { i(1, "i"), i(2, "value"), i(3, "t") }),
					fmta("<>, <> in pairs(<>)", { i(1, "key"), i(2, "value"), i(3, "t") }),
					fmta("i = <>, <>", { i(1, "1"), i(2, "10,1") }),
				}),
				i(0),
			}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "lw", dscr = "Loop (while)" },
		fmta(
			[[
	while (<>) do
		<>
	end
]],
			{ i(1), i(0) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "r", dscr = "Return" },
		fmta(
			[[
	return <>
]],
			{ i(0) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "F", dscr = "False" },
		fmta(
			[[
	false
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "T", dscr = "True" },
		fmta(
			[[
	true
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "N", dscr = "Null" },
		fmta(
			[[
	nil
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "p", dscr = "Print (debug)" },
		fmta(
			[[
	print(<>)
]],
			{ c(1, { fmta("vim.inspect(<>)", { r(1, "msg") }), r(1, "msg") }) }
		),
		{ stored = { msg = v(1, nil, true) } }
	)
)

table.insert(
	M,
	s(
		{ trig = "t", dscr = "Try-catch" },
		fmta(
			[[
	xpcall(function ()
		<>
	end, function(err)
	end)
]],
			{ i(0) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "err", dscr = "Raise error" },
		fmta(
			[[
	error(<>)
]],
			{ v(1) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "v", dscr = "Variable" },
		fmta(
			[[
	local <> = <>
]],
			{ i(1, "var_a"), i(0, "value") }
		)
	)
)

return M
-- vim: noet
