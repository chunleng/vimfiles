local M = {}

table.insert(
	M,
	s(
		{ trig = "----dioxus/init", dscr = "Template for Dioxus Init" },
		fmta(
			[[
	use dioxus::prelude::*;

	fn main() {
		dioxus::launch(|| rsx! { "Hello World!" });
	}

]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "----dioxus/component", dscr = "Template for dioxus component" },
		fmta(
			[[
	#[component]
	fn <>() ->> Element {
		rsx! { <> }
	}
]],
			{ i(2, "Func"), i(0) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "----dioxus/signal", dscr = "Template for dioxus signal" },
		fmta(
			[[
	let mut <> = use_signal(|| <>);<>
]],
			{ i(1, "loading"), i(2, "false"), i(0) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "----dioxus/use_effect", dscr = "Template for dioxus effect" },
		fmta(
			[[
	use_effect(|| {
		<>
	});
]],
			{ i(0) }
		)
	)
)

return M
-- vim: noet
