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
			trig = "?neotest/python",
			dscr = "Template for setting up a python neotest project",
		},
		fmta(
			[[
	require('neotest').setup_project('.', {
	    -- https://github.com/nvim-neotest/neotest-python#neotest-python
	    adapters = {require('neotest-python')({})},
	    default_strategy = "integrated"
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
			trig = "?neotest/javascript/jest",
			dscr = "Template for setting up a Javascript Jest neotest project",
		},
		fmta(
			[[
	require('neotest').setup_project('.', {
	    -- https://github.com/nvim-neotest/neotest-jest#neotest-jest
	    adapters = {require('neotest-jest')({})},
	    default_strategy = "integrated"
	})
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "?overseer/setup", dscr = "Template to setup overseer" },
		fmta(
			[[
local overseer_group_name = 'OverseerCustom'
local overseer_bundle_name = '<>'
local overseer_bundle = require('overseer.task_bundle')
vim.api.nvim_create_augroup(overseer_group_name, {clear = true})
vim.api.nvim_create_autocmd('VimEnter', {
	buffer = 0,
	callback = function()
	overseer_bundle.load_task_bundle(overseer_bundle_name, {
		ignore_missing = true,
		autostart = false
	})
	end,
	group = overseer_group_name
})
vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        local utils = require('common-utils')
        utils.keymap('n', '<<c-s>>', function()
            overseer_bundle.save_task_bundle(overseer_bundle_name, nil,
                                             {on_conflict = 'overwrite'})
        end, {buffer = true})
    end,
    pattern = {'OverseerList'},
    group = overseer_group_name
})

]],
			{ i(1, "bundle_name") }
		)
	)
)

return M
-- vim: noet
