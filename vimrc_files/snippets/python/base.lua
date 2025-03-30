local M = {}

local function get_file_upper_camel(_, snip)
	return sn(nil, {
		i(1, require("utils").snake_to_upper_camel(snip.env.TM_FILENAME:match("^(.+)%..+$"))),
	})
end

table.insert(
	M,
	s(
		{ trig = "imp", dscr = "Import" },
		c(1, {
			fmta("from <> import ", { i(1, "lib") }),
			fmta("import ", {}),
		})
	)
)

table.insert(
	M,
	s(
		{ trig = "c", dscr = "Class" },
		fmta(
			[[
	class <>:
		<>
]],
			{
				c(1, {
					d(1, get_file_upper_camel, {}),
					sn(nil, {
						d(1, function(_, snip)
							return get_file_upper_camel(nil, snip.snippet)
						end, {}),
						t("("),
						i(2, "Bar"),
						t(")"),
					}),
				}),
				i(0),
			}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "en", dscr = "Enum" },
		fmta(
			[[
	class <>(enum.Enum):
		<>
]],
			{ d(1, get_file_upper_camel, {}), i(0) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "f", dscr = "Function" },
		c(1, {
			fmta(
				[[
	def <>(self<>):
		<>
]],
				{ i(1, "__init__"), i(2), i(0) }
			),
			fmta(
				[[
	@classmethod
	def <>(cls<>):
		<>
]],
				{ i(1, "foo_a"), i(2, ", var_a"), i(0) }
			),
		})
	)
)

table.insert(
	M,
	s(
		{ trig = "fx", dscr = "Lambda Function" },
		fmta(
			[[
	lambda <> : <>
]],
			{ i(1, "x"), i(0, "x + 1") }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "?", dscr = "Ternary if" },
		c(1, {
			fmta("<> or <>", { i(1, "var_a"), i(2, "var_b") }),
			fmta("<> if <> else <>", { i(2, "var_a"), i(1, "var_a"), i(3, "var_b") }),
		})
	)
)

table.insert(
	M,
	s(
		{ trig = "i", dscr = "If" },
		fmta(
			[[
	if <>:
		<>
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
	else:
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
	elif <>:
		<>
]],
			{ i(1), i(0) }
		)
	)
)

table.insert(M, s({ trig = "o", dscr = "Short-circuit or" }, t("or ")))
table.insert(M, s({ trig = "a", dscr = "Short-circuit and" }, t("and ")))
table.insert(M, s({ trig = "n", dscr = "Boolean not" }, t("not ")))
table.insert(M, s({ trig = "ne", dscr = "Not equal" }, t("!= ")))

table.insert(
	M,
	s(
		{ trig = "s", dscr = "Switch case" },
		fmta(
			[[
	match <>:
		case <>:
			<>
]],
			{ i(1), i(2, "_"), i(0) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "l", dscr = "Loop (for)" },
		fmta(
			[[
	for <>:
		<>
]],
			{
				c(1, {
					fmta("<> in <>", { i(1, "value"), i(2, "lst") }),
					fmta("<>, <> in <>.items()", { i(1, "key"), i(2, "value"), i(3, "dct") }),
					fmta("<>, <> in enumerate(<>)", { i(1, "i"), i(2, "value"), i(3, "lst") }),
					fmta(
						"<>, (<>, <>) in enumerate(<>.items())",
						{ i(1, "i"), i(2, "key"), i(3, "value"), i(4, "dct") }
					),
					fmta("<> in range(<>)", { i(1, "i"), i(2, "10") }),
				}),
				i(0),
			}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "lc", dscr = "List Comprehension" },
		fmta(
			[[
	[<> for <> in <>]
]],
			{ i(3, "x"), i(1, "x"), i(2, "lst if x == 1") }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "lw", dscr = "Loop (while)" },
		fmta(
			[[
	while <>:
		<>
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
	False
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
	True
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
	None
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
			{ v(1) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "t", dscr = "Try-catch" },
		fmta(
			[[
	try:
		<>
	except Exception as e:
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
	raise <>
]],
			{ i(0, "Exception()") }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "v", dscr = "Variable" },
		fmta(
			[[
	<> = <>
]],
			{ i(1, "var_a"), i(0, "value") }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "V", dscr = "Constant" },
		fmta(
			[[
	<> = <>
]],
			{ i(1, "CONST_A"), i(0, "value") }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "@", dscr = "Annotation" },
		fmta(
			[[
	@<>
]],
			{ i(0, "dataclass") }
		)
	)
)

return M
-- vim: noet
