local M = {}

table.insert(
	M,
	s(
		{
			trig = "?lua/autoformat_on_save",
			dscr = "Template for invoking format on save",
		},
		fmta(
			[[
	local group_name = 'LspAutoformat'
	vim.api.nvim_create_augroup(group_name, {clear = true})
	vim.api.nvim_create_autocmd('BufWritePre', {
		buffer = 0,
		callback = function() vim.lsp.buf.format({timeout_ms=5000}) end,
		group = group_name
	})
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{
			trig = "?dadbod/db_setup",
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
		{ trig = "?dap/python", dscr = "Template for DAP Python" },
		fmta(
			[[
	-- For reference to the debugpy settings:
	-- https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
	local function dap_python(config)
		return vim.tbl_extend('force', {
			type = 'python',
			request = 'launch',
			console = 'externalTerminal',
			pythonPath = os.getenv('VIRTUAL_ENV') .. '/bin/python',
			cwd = vim.fn.getcwd()
		}, config)
	end
	require('dap').configurations.python = {
		dap_python({
			name = 'Launch current',
			program = '${file}' -- current file
		}), dap_python({
			name = 'Test current',
			code = 'import pytest; pytest.main(["${file}"])'
		})
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
			trig = "?projectionist/project_setup",
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
			trig = "?vim-test",
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
