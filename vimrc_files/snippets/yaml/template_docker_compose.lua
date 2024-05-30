local M = {}

table.insert(
	M,
	s(
		{
			trig = "?docker_compose/init",
			dscr = "Template for docker-compose init",
		},
		fmta(
			[[
	services:
		web:
			image: <>
			ports:
				- "<>"
			volumes:
				- <>
		<>
]],
			{
				i(1, "imagename:version"),
				i(2, "host:docker"),
				i(3, "local_path:docker_path"),
				i(0),
			}
		)
	)
)

return M
-- vim: noet
