local M = {}

table.insert(
	M,
	s(
		{
			trig = "?terraform/aws_ami_amazon_linux_2",
			dscr = "Amazon Linux 2 AMI",
		},
		fmta(
			[[
	data "aws_ami" "<>" {
		name_regex  = "^amzn2-ami-hvm.*ebs$"
		most_recent = true
		owners      = ["amazon"]

		filter {
			name   = "architecture"
			values = ["x86_64"]
		}
	}
]],
			{ i(1, "ami_name") }
		)
	)
)

table.insert(
	M,
	s(
		{
			trig = "?terraform/lifecycle_ignore_changes",
			dscr = "Template for ignoring changes",
		},
		fmta(
			[[
	lifecycle {
		ignore_changes = [
			<>
		]
	}
]],
			{ i(0) }
		)
	)
)

return M
-- vim: noet
