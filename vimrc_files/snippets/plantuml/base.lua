local M = {}

table.insert(
	M,
	s(
		{ trig = "note", dscr = "Plantuml comment" },
		fmta(
			[[
	note right
		<>
	end note
]],
			{ i(1, "comment_multiline") }
		)
	)
)
return M
-- vim: noet
