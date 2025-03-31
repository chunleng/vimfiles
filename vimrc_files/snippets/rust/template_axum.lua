local M = {}

table.insert(
	M,
	s(
		{ trig = "----axum/init", dscr = "Template for Axum Init" },
		fmta(
			[[
	use std::error::Error;

	use axum::{Router, routing::get};
	use tokio::net::TcpListener;

	#[tokio::main]
	async fn main() ->> Result<<(), Box<<dyn Error>>>> {
		let app = Router::new().route("/", get(|| async { "Hello world" }));
		let listener = TcpListener::bind("127.0.0.1:3000").await?;
		axum::serve(listener, app).await?;

		Ok(())
	}
]],
			{}
		)
	)
)

return M
-- vim: noet
