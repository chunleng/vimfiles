local M = {}

table.insert(
	M,
	s(
		{ trig = "----mcp/init", dscr = "Template for .mcp.json" },
		fmta(
			[[
	{
		"servers": {
			<>
		}
	}
]],
			{ i(0) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "----mcp/github", dscr = "Add GitHub remote MCP" },
		fmta(
			[[
	"github": {
		"type": "http",
		"url": "https://api.githubcopilot.com/mcp/",
		"headers": {
			"Authorization": "Bearer <>"
		}
	}
]],
			{ i(0) }
		)
	)
)

return M
-- vim: noet
