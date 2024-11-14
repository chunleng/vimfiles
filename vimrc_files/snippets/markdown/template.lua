local M = {}

table.insert(
	M,
	s(
		{
			trig = "?git/readme",
			dscr = "Template for README.md of Git Repository",
		},
		fmt(
			[[
    # {}

    ## Features

    - ...

    ## Quickstart

    You can install the package by...

    ## Contribution/Development Setup

    <!-- Contribution -->
    Your help is greatly appreciated! You can contribute by reporting issues or
    suggesting new features or a pull request. Please check out
    [CONTRIBUTING.md](./CONTRIBUTING.md) for more details

    <!-- Development Setup -->
    This section covers the necessary steps to setup your environment for
    development

    ### Prerequisite

    - [asdf](https://github.com/asdf-vm/asdf)

    ### Build & Run

    \`\`\`bash
    make install
    make run
    \`\`\`

    ### Credits

    I would like to thank...
]],
			{ i(0, "App Name") }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "?git/readme/sandbox", dscr = "Template for github.com/chunleng/sandbox's README.md" },
		fmta(
			[[
    # <>

    <>

    ## Status

    WIP

    ## Getting Started

    ```

    ```
]],
			{ i(1, "Sandbox"), i(0) }
		)
	)
)

return M
-- vim: noet
