local M = {}

table.insert(
	M,
	s(
		{ trig = "?ratatui/init", dscr = "Template for ratatui init" },
		fmta(
			[[
	use std::error::Error;

	use crossterm::event::{self, Event, KeyCode};
	use ratatui::{DefaultTerminal, Frame, buffer::Buffer, layout::Rect, text::Text, widgets::Widget};

	fn main() ->> Result<<(), Box<<dyn Error>>>> {
		let mut terminal = ratatui::init();
		let app_result = App::new().run(&mut terminal);
		ratatui::restore();

		app_result
	}

	struct App {
		exit: bool,
	}

	impl App {
		fn new() ->> Self {
			Self { exit: false }
		}

		fn run(&mut self, terminal: &mut DefaultTerminal) ->> Result<<(), Box<<dyn Error>>>> {
			while !self.exit {
				terminal.draw(|frame| self.draw(frame))?;
				self.handle_event()?;
			}
			Ok(())
		}

		fn draw(&self, frame: &mut Frame) {
			frame.render_widget(self, frame.area());
		}

		fn handle_event(&mut self) ->> Result<<(), Box<<dyn Error>>>> {
			match event::read()? {
				Event::Key(k) if k.code == KeyCode::Char('q') || k.code == KeyCode::Char('Q') =>> {
					self.exit = true;
				}
				_ =>> {}
			}
			Ok(())
		}
	}

	impl Widget for &App {
		fn render(self, area: Rect, buf: &mut Buffer) {
			Text::raw("Press 'Q' to quit").render(area, buf)
		}
	}
]],
			{}
		)
	)
)

return M
-- vim: noet
