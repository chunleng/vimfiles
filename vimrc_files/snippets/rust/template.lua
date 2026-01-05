local M = {}

local function get_file_upper_camel(_, snip)
	snip = snip.snippet or snip
	return sn(nil, {
		i(1, require("utils").snake_to_upper_camel(snip.env.TM_FILENAME:match("^(.+)%..+$"))),
	})
end

table.insert(
	M,
	s(
		{ trig = "----main", dscr = "Template for main function" },
		fmta(
			[[
	<><>
		Ok(())
	}]],
			{
				c(1, {
					fmta(
						[[
	fn main() ->> Result<<(), Box<<dyn Error>>>>  {
		<>]],
						{ i(1) }
					),
					fmta(
						[[
	#[tokio::main]
	async fn main() ->> Result<<(), Box<<dyn Error>>>>  {
		<>]],
						{ i(1) }
					),
				}),
				i(0),
			}
		)
	)
)

table.insert(
	M,
	s(
		{
			trig = "----test/init",
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
		{ trig = "----test", dscr = "Template for creating a new test" },
		c(1, {
			fmta(
				[[
	#[test]
	fn <>() {
		<>
	}
]],
				{ i(1, "test_func_name"), i(0, "assert_eq!(1 + 1, 2);") }
			),
			fmta(
				[[
	#[tokio::test]
	async fn <>() {
		<>
	}
]],
				{ i(1, "test_func_name"), i(0, "assert_eq!(1 + 1, 2);") }
			),
		})
	)
)

table.insert(
	M,
	s(
		{ trig = "----benchmark", dscr = "" },
		fmta(
			[[
let start = Instant::now();
println!("Parallel sum: {}", <>);
println!("Time elapsed for <> is: {:?}", start.elapsed());
]],
			{ v(1, "func()"), l(l._1, 1) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "----error", dscr = "Template for error struct" },
		fmta(
			[[
	#[derive(Error, Debug)]
	pub enum <> {
		#[error("Unknown error: {message}\n{source}")]
		Unhandled {
			message: String,
			#[source]
			source: Box<<dyn std::error::Error>>,
		},
	}
]],
			{ d(1, get_file_upper_camel, {}) }
		)
	)
)
return M
-- vim: noet
