local M = {}

table.insert(
	M,
	s(
		{ trig = "?http/grpc", dscr = "Template for using gRPC" },
		fmta(
			[[
	# @grpc-global-import-path ../protos
	# @grpc-global-proto helloworld.proto
	# @grpc-plaintext
	GRPC {{URL}} <>
]],
			{ i(1, "helloworld.Greeter/SayHello") }
		)
	)
)

return M
-- vim: noet
