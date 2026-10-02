local M = {}

table.insert(
	M,
	s(
		{ trig = "----lua/localvimrc_init", dscr = "Init for localvimrc" },
		fmta(
			[[
	------------------------------
	-- Load every buffer change --
	------------------------------

	if vim.g.localvimrc_sourced_once_for_file == 1 then
		return
	end
	-----------------------------
	-- Load once for each file --
	-----------------------------

	if vim.g.localvimrc_sourced_once == 1 then
		return
	end
	--------------------------------
	-- Load once per vim instance --
	--------------------------------

	require("conform").formatters_by_ft = {
		lua = { "stylua" },
	}
	require("conform").formatters.stylua = {
		command = vim.fn.trim(vim.fn.system(
			"ASDF_DEFAULT_TOOL_VERSIONS_FILENAME=.vim/.tool-versions asdf which stylua"
		)),
	}
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{
			trig = "----dadbod/db_setup",
			dscr = "Template for Vim Dadbod Setup",
		},
		fmta(
			[[
	-- :h dadbod
	vim.g.dbs = {
		{ name = "dev-pg", url = "postgres://postgres:password@localhost:5432/db"},
		{ name = "dev-mysql", url = "mysql://mysql:password@127.0.0.1:3306/db?default-character-set=utf8"}
	}
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{
			trig = "----projectionist/project_setup",
			dscr = "Template for the projectionist setup",
		},
		fmta(
			[[
	-- :h projectionist
	vim.g.projectionist_heuristics = {
		['*'] = {
			['src/*.py'] = {
				alternate = 'tests/{dirname}/test_{basename}.py',
				type = 'source'
			},
			['tests/**/test_*.py'] = {
				alternate = 'src/{dirname}/{basename}.py',
				type = 'test'
			}
		}
	}
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{
			trig = "----vim-test",
			dscr = "Template for setting up vimtest",
		},
		fmta(
			[=[
	-- Check the following for setup
	-- https://github.com/vim-test/vim-test?tab=readme-ov-file#features
	vim.cmd[[
		let test#<>#<>#executable = '<>'
	]]
]=],
			{ i(1, "python"), i(2, "pytest"), i(0, "poetry run pytest") }
		)
	)
)

return M
-- vim: noet
