local M = {}

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
		{
			stored = { name = i(1, "ClassA"), args = i(2, "varA: number, varB: string") },
		}
	)
)

table.insert(
	M,
	s(
		{ trig = "en", dscr = "Enum" },
		fmta(
			[[
	enum <> {
		VAL_A,
		VAL_B
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
	function <>(<>): <> {
		<>
	}
]],
			{ i(1, "functionA"), i(2, "argA: number"), i(3, "number"), i(0) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "fx", dscr = "Lambda Function" },
		c(1, {
			fmta(
				[[
	(<>) =>> { <> }
	]],
				{ i(1), i(2) }
			),
			fmt(
				[[
	{}: {} => 
]],
				{ i(1, "x"), i(2, "number") }
			),
		})
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
			{ i(1, "varA: number"), i(2, "value") }
		)
	)
)

return M
-- vim: noet
