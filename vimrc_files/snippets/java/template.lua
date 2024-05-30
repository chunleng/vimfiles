local M = {}

table.insert(
	M,
	s(
		{ trig = "?main", dscr = "Java main function" },
		fmta(
			[[
	public static void main(String[] args) {
		<>
	}
]],
			{ i(0) }
		)
	)
)

return M
-- vim: noet
