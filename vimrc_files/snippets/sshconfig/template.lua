local M = {}

table.insert(
	M,
	s(
		{ trig = "----sshconfig/default", dscr = "Default template for SSH Configuration" },
		fmta(
			[[
	Host <>
		HostName <>
		Port 22
		IdentityFile ~/.ssh/id_rsa

		# Make server alive for 2 hours
		ServerAliveInterval 120
		ServerAliveCountMax 60

		User <>

]],
			{ i(1, ""), i(2, "13.0.0.1"), i(3, "ec2-user") }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "----sshconfig/proxy", dscr = "Template for proxy connect to server" },
		fmta(
			[[
	Host <>
		HostName <>
		Port 22
		IdentityFile ~/.ssh/id_rsa

		# Make server alive for 2 hours
		ServerAliveInterval 120
		ServerAliveCountMax 60
		ProxyCommand ssh -i ~/.ssh/id_rsa -W %h:%p user@step-server

		User <>
		]],
			{ i(1, ""), i(2, "13.0.0.1"), i(3, "ec2-user") }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "----sshconfig/port-forwarding", dscr = "Template for port-forwarding from a server" },
		fmta(
			[[
	Host <>
		HostName <>
		Port 22
		IdentityFile ~/.ssh/id_rsa

		# Make server alive for 2 hours
		ServerAliveInterval 120
		ServerAliveCountMax 60
		LocalForward 3306 <>:3306

		User <>
		]],
			{ i(1, ""), i(2, "13.0.0.1"), i(3, "13.0.0.2"), i(4, "ec2-user") }
		)
	)
)

return M
-- vim: noet
