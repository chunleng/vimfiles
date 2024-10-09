local M = {}

table.insert(
	M,
	s(
		{
			trig = "?rust/cargo_init_workspace",
			dscr = "Template for Cargo workspace",
		},
		fmta(
			[[
[workspace]

resolver = "2"
members = [
	"<>"
]
]],
			{ i(1, "path/to/member") }
		)
	)
)

return M
-- vim: noet
