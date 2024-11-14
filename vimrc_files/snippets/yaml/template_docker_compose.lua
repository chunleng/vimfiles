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
			image: imagename:version
			ports:
				- host:docker
			volumes:
				- web_volume:docker_path
			networks:
				- intranet

	volumes:
		web_volume:

	networks:
		intranet:
]],
			{}
		)
	)
)

return M
-- vim: noet
