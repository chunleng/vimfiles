local M = {}

table.insert(
	M,
	s(
		{ trig = "?skaffold/init", dscr = "Template for Skaffold init" },
		fmta(
			[[
	apiVersion: skaffold/v3
	kind: Config
	build:
		local:
			push: false
			concurrency: 0
		artifacts:
			- image: <>
				docker:
					dockerfile: Dockerfile
					target: prod_backend
				sync:
					infer:
						- "host_path/**/*"

	profiles:
		- name: dev
			activation:
				- command: dev
			manifests:
				kustomize:
					paths:
					  - "k8s/overlays/dev"

	portForward:
		- resourceType: service
			resourceName: service-name
			namespace: default
			port: 80
			localPort: 8080
]],
			{ i(0, "image-name") }
		)
	)
)

return M
-- vim: noet
