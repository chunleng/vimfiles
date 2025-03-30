local M = {}

local function get_file_name(_, snip)
	snip = snip.snippet or snip
	return sn(nil, { i(1, snip.env.TM_FILENAME:match("^(.+)%..+$")) })
end

table.insert(M, s({ trig = "imp", dscr = "Import" }, fmta("import <>;", { i(0, "lib") })))

table.insert(
	M,
	s(
		{ trig = "c", dscr = "Class" },
		fmta(
			[[
	public class <> {
		<>
	}
]],
			{
				c(1, {
					r(1, "classname"),
					sn(nil, { r(1, "classname"), t(" implements "), r(2, "interface") }),
					sn(nil, { r(1, "classname"), t(" extends "), r(2, "inheritance") }),
				}),
				i(0),
			}
		),
		{
			stored = {
				classname = d(1, get_file_name, {}),
				interface = i(1, "Foo"),
				inheritance = i(1, "Bar"),
			},
		}
	)
)

table.insert(
	M,
	s(
		{ trig = "en", dscr = "Enum" },
		fmta(
			[[
	public enum <> {
		<>
	}
]],
			{ d(1, get_file_name, {}), i(0, { "FOO,", "\tBAR" }) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "if", dscr = "Interface" },
		fmta(
			[[
	public interface <> {
		<>
	}
]],
			{ d(1, get_file_name, {}), i(0) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "f", dscr = "Function" },
		fmta(
			[[
	private <> <>(<>) {
		<>
	}
]],
			{ i(1, "int"), i(2, "fooA"), i(3, "String varA"), i(0) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "fx", dscr = "Lambda Function" },
		fmta(
			[[
	(<>) ->> { <> }
]],
			{ i(1, "x"), i(0, "System.out.println(x);") }
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
	} else if (<>) {
		<>
]],
			{ i(1), i(0) }
		)
	)
)

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
	for (<>) {
		<>
	}
]],
			{
				c(1, {
					fmta("<> : <>", { i(1, "Map.Entry<String, String> arr"), i(2, "hm.entrySet()") }),
					fmt("int {} = 0; {} < {}; {}++", { i(1, "i"), l(l._1, 1), i(2, "10"), l(l._1, 1) }),
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
	return <>;
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
		{ trig = "T", dscr = "False" },
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
		{ trig = "p", dscr = "Print (debug)" },
		fmta(
			[[
	System.out.println(<>);
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
	<> <> = <>;
]],
			{ i(1, "ArrayList"), i(2, "varA"), i(0, "new ArrayList()") }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "n", dscr = "Null" },
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
		{ trig = "@", dscr = "Annotation" },
		fmta(
			[[
	@<>
]],
			{ i(0, "Override") }
		)
	)
)

return M

-- vim: noet
