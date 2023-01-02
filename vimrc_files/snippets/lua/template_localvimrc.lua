local M = {}

table.insert(M, s({
    trig = 'template/lua/autoformat_on_save',
    dscr = 'Template for invoking format on save'
}, fmta([[
	local group_name = 'LspAutoformat'
	vim.api.nvim_create_augroup(group_name, {clear = true})
	vim.api.nvim_create_autocmd('BufWritePre', {
		buffer = 0,
		callback = function() vim.lsp.buf.format({timeout_ms=5000}) end,
		group = group_name
	})
]], {})))

table.insert(M,
             s(
                 {
        trig = 'template/dadbod/db_setup',
        dscr = 'Template for Vim Dadbod Setup'
    }, fmta([[
	-- :h dadbod
	vim.g.dbs = {
		{ name = "dev-pg", url = "postgres://postgres:password@localhost:5432/db"},
		{ name = "dev-mysql", url = "mysql://mysql:password@127.0.0.1:3306/db?default-character-set=utf8"}
	}
]], {})))

table.insert(M,
             s({trig = 'template/dap/python', dscr = 'Template for DAP Python'},
               fmta([[
	local function dap_python(config)
		return vim.tbl_extend('force', {
			type = 'python',
			request = 'launch',
			console = 'externalTerminal',
			pythonPath = os.getenv('VIRTUAL_ENV') .. '/bin/python'
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
]], {})))

table.insert(M, s({
    trig = 'template/projectionist/project_setup',
    dscr = 'Template for the projectionist setup'
}, fmta([[
	vim.g.projectionist_heuristics = {
		['*'] = {
			['src/main/java/*.java'] = {
				alternate = 'src/test/java/{}.java',
				type = 'source'
			},
			['src/test/java/*.java'] = {
				alternate = 'src/main/java/{}.java',
				type = 'test'
			}
		}
	}
]], {})))

return M
-- vim: noet

