local M = {}

table.insert(
	M,
	s(
		{ trig = "?axum/init", dscr = "Template for Axum Init" },
		fmta(
			[[
	use axum::{routing::get, Router};

	#[tokio::main]
	async fn main() {
		let app = Router::new().route("/", get(|| async { "Hello world" }));
		axum::Server::bind(&"127.0.0.1:3000".parse().unwrap())
			.serve(app.into_make_service())
			.await
			.unwrap();
	}
]],
			{}
		)
	)
)

return M
-- vim: noet
