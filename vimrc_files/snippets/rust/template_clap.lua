local M = {}

table.insert(
	M,
	s(
		{ trig = "?clap/init", dscr = "Template for Clap Init" },
		fmta(
			[[
	use clap::{Parser, Subcommand};

	#[derive(Parser)]
	#[command(version, about, long_about = None)]
	struct Cli {
		#[arg(short, long)]
		flag: Option<<String>>,

		#[command(subcommand)]
		command: Commands,
	}

	#[derive(Subcommand)]
	enum Commands {
		A {
			#[arg(short, long)]
			flag: String,
		},
		B {
			pos_arg: String,
		},
	}

	fn main() {
		let args = Cli::try_parse();
		match args {
			Ok(args) =>> {
				println!("{:?}", args.flag);
			}
			Err(msg) =>> {
				let _ = msg.print();
			}
		}
	}
]],
			{}
		)
	)
)

return M
-- vim: noet
