local M = {}

table.insert(
	M,
	s(
		{ trig = "?scraper/init", dscr = "Template for Scraper Init" },
		fmta(
			[[
use reqwest::{get, Result};
use scraper::{Html, Selector};

#[tokio::main]
async fn main() ->> Result<<()>> {
	let document = get("https://example.com").await?.text().await?;
	let fragment = Html::parse_fragment(&document);
	let article = fragment
		.select(&Selector::parse(".selector").unwrap())
		.next();
	println!("{:?}", article);
	Ok(())
}
]],
			{}
		)
	)
)

return M
-- vim: noet
