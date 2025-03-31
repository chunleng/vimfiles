local M = {}

table.insert(
	M,
	s(
		{
			trig = "----javascript/array_object_to_dictionary",
			dscr = "Template to convert an array of objects into dictonary",
		},
		fmta(
			[[
	Object.assign({}, ...<>.map(x =>> ({ [x.<>]: x.<> })))
]],
			{ i(1, "target"), i(2, "key"), i(3, "value") }
		)
	)
)

-- TODO check if there is a better way to autogenerate the snippet via LSP
table.insert(
	M,
	s(
		{ trig = "new Promise", dscr = "Template for new promise" },
		fmta(
			[[
	new Promise((resolve, reject) =>> { <> })
]],
			{ i(0) }
		)
	)
)

return M
-- vim: noet
