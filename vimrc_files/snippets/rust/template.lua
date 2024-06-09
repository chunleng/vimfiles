local M = {}

table.insert(
	M,
	s(
		{
			trig = "?test/init",
			dscr = "Template for starting unit testing",
		},
		fmta(
			[[
	#[cfg(test)]
	mod tests {
		use super::*;
	}
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "?test", dscr = "Template for creating a new test" },
		c(1, {
			fmta(
				[[
	#[test]
	fn <>() {
		<>
	}
]],
				{ i(1, "func_name"), i(0, "assert_eq!(1 + 1, 2);") }
			),
			fmta(
				[[
	#[tokio::test]
	async fn <>() {
		<>
	}
]],
				{ i(1, "func_name"), i(0, "assert_eq!(1 + 1, 2);") }
			),
		})
	)
)
return M
-- vim: noet
