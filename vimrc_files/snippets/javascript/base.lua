local M = {}

table.insert(
	M,
	s(
		{ trig = "imp", dscr = "Import" },
		fmta(
			[[
    import <>
]],
			{
				c(1, {
					fmta('{ <> } from "<>"', { i(2), r(1, "lib") }),
					fmta('<> from "<>"', { i(2), r(1, "lib") }),
				}, { stored = { lib = i(1) } }),
			}
		)
	)
)

function f_assignment(args)
	local arglist = vim.split(args[1][1], ",")
	for i = 1, #arglist do
		arglist[i] = arglist[i]:gsub("^%s*([a-zA-Z_]+[a-zA-Z_0-9]*).*$", "this.%1 = %1;")
	end
	return isn(nil, t(arglist), "$PARENT_INDENT\t\t")
end
table.insert(
	M,
	s(
		{ trig = "c", dscr = "Class" },
		c(1, {
			fmta(
				[[
		class <> {
			constructor(<>) {
				<>
			}
		}
	]],
				{ r(1, "name"), r(2, "args"), d(3, f_assignment, { 2 }) }
			),
			fmta(
				[[
		const <> = class {
			constructor(<>) {
				<>
			}
		}
	]],
				{ r(1, "name"), r(2, "args"), d(3, f_assignment, { 2 }) }
			),
		}),
		{ stored = { name = i(1, "ClassA"), args = i(2, "varA, varB") } }
	)
)

table.insert(
	M,
	s(
		{ trig = "en", dscr = "Enum" },
		fmta(
			[[
	const <> = {
		VAL_A: 0,
		VAL_B: 1
	}
]],
			{ i(1, "EnumA") }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "f", dscr = "Function" },
		fmta(
			[[
	function <>(<>) {
		<>
	}
]],
			{ i(1, "functionA"), i(2, "argA"), i(0) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "fx", dscr = "Lambda Function" },
		c(1, {
			fmt(
				[[
	{} => 
]],
				{ i(1, "x") }
			),
			fmta(
				[[
	(<>) =>> { <> }
	]],
				{ i(1), i(2) }
			),
		})
	)
)

table.insert(
	M,
	s(
		{ trig = "?", dscr = "Ternary-if" },
		fmta(
			[[
	<> ? <> : <>
]],
			{ i(1, 'fooA == "bar"'), i(2, '"a"'), i(0, '"b"') }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "i", dscr = "If" },
		fmta(
			[[
	if (<>) {
		<>
	}
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
	} else {
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "ei", dscr = "Else-if" },
		fmta(
			[[
	} else if (<>) {
]],
			{ i(1) }
		)
	)
)

table.insert(M, s({ trig = "o", dscr = "Short-circuit or" }, t("|| ")))
table.insert(M, s({ trig = "a", dscr = "Short-circuit and" }, t("&& ")))
table.insert(M, s({ trig = "ne", dscr = "Not equal" }, t("!= ")))

table.insert(
	M,
	s(
		{ trig = "s", dscr = "Switch-case" },
		fmta(
			[[
	switch (<>) {
		case '<>':
			break;
		<>
	}
]],
			{ i(1, "varA"), i(2, "value"), i(0, "default: ;") }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "l", dscr = "Loop (for)" },
		fmta(
			[[
	for (<>) {
		<>
	}
]],
			{
				c(1, {
					fmta("<> of <>", { r(1, "var_name"), i(2, "arrA") }),
					fmta("<> in <>", { r(1, "var_name"), i(2, "objA") }),
					fmt(
						"let {} = 0; {} < {}.length; {}++",
						{ r(1, "var_name"), l(l._1, { 1 }), i(2, "arr.length"), l(l._1, { 1 }) }
					),
				}),
				i(0),
			}
		),
		{ stored = { var_name = i(1, "i") } }
	)
)

table.insert(
	M,
	s(
		{ trig = "lw", dscr = "Loop (while)" },
		c(1, {
			fmta(
				[[
		while (<>) {
			
		}
	]],
				{ r(1, "expr") }
			),
			fmta(
				[[
		do {
			
		} while (<>);
	]],
				{ r(1, "expr") }
			),
		}),
		{ stored = { expr = i(1) } }
	)
)

table.insert(
	M,
	s(
		{ trig = "r", dscr = "Return" },
		fmta(
			[[
	return <>;
]],
			{ i(1) }
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

table.insert(M, s({ trig = "N", dscr = "Null" }, t("null")))

table.insert(
	M,
	s(
		{ trig = "p", dscr = "Debug print" },
		fmta(
			[[
	console.log(<>)
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
	try {
		<>
	} catch (error) {
	}
]],
			{ i(0) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "err", dscr = "Raise Exception" },
		fmta(
			[[
	throw new <>(<>);
]],
			{ i(1, "Error"), i(2) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "v", dscr = "Variable" },
		fmta(
			[[
	let <> = <>;
]],
			{ i(1, "varA"), i(2, "value") }
		)
	)
)

return M
-- vim: noet
