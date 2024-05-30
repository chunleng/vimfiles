local M = {}

table.insert(
	M,
	s(
		{ trig = "?apt/install", dscr = "Apt update and install" },
		fmta(
			[[
RUN apt-get update && \
    apt-get install -y <> && \
    rm -rf /var/lib/apt/lists/*
]],
			{ i(1, "curl") }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "?apk/install", dscr = "Alpine apk install" },
		fmta(
			[[
RUN apk add --no-cache <>
]],
			{ i(1, "curl") }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "?poetry/install", dscr = "Poetry install" },
		fmta(
			[[
RUN pip install poetry && \
    poetry install && \
    rm -rf ~/.cache
]],
			{}
		)
	)
)

return M
-- vim: noet
