local M = {}

table.insert(
	M,
	s(
		{ trig = "?leptos/init", dscr = "Template for Leptos Init" },
		fmta(
			[[
	use leptos::prelude::*;

	fn main() {
		mount_to_body(|| view! { <<p>>"Hello, world!"<</p>> })
	}
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{
			trig = "?leptos/component",
			dscr = "Template for Leptos component",
		},
		fmta(
			[[
	#[component]
	fn <>() ->> impl IntoView {
		view! { <> }
	}
]],
			{ i(1, "ComponentName"), i(0, '<p>"Foo"</p>') }
		)
	)
)

table.insert(
	M,
	s(
		{
			trig = "?leptos/signal",
			dscr = "Template for creating Leptos signal",
		},
		fmta(
			[[
	let (<>, set_<>) = signal(<>);
]],
			{ i(1, "count"), l(l._1, 1), i(2, '"foo".to_string()') }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "?leptos/effect", dscr = "Template for creating Leptos effect" },
		fmta(
			[[
	Effect::new(move |_| {
		<>
	});
]],
			{ i(0) }
		)
	)
)

table.insert(
	M,
	s(
		{
			trig = "?leptos/action",
			dscr = "Template for creating Leptos action",
		},
		fmta(
			[[
	let <> = Action::new_local(|<>| {
		<>
		async {}
	});
]],
			{
				i(1, "handle_click"),
				i(2, "(): &()"),
				i(0),
			}
		)
	)
)

return M
-- vim: noet
