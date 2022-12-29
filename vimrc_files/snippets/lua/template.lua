local M = {}

table.insert(M,
             s(
                 {
        trig = 'template/lua/autocommand_new',
        dscr = 'Template for autocommand'
    }, fmta([[
	local group_name = "<>"
	vim.api.nvim_create_augroup(group_name, {clear = true})
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "<>",
		callback = function() vim.bo.expandtab = false end,
		group = group_name
	})
	]], {i(1, 'group_name'), i(2, 'filetype')}, {})))

table.insert(M, s({trig = 'print/inspect', dscr = 'Print vim.inspect'}, fmta([[
	print(vim.inspect(<>))
]], {v(1)})))

table.insert(M,
             s({trig = 'template/lua/module', dscr = 'Template for Lua Module'},
               fmta([[
	local M = {}

	function M.setup()
		<>
	end

	return M
]], {i(0)})))

table.insert(M,
             s({trig = 'template/lua/vimtest', dscr = 'Template for Vimtest'},
               fmta([[
	-- https://github.com/vim-test/vim-test#features
	vim.g['test#<>#runner'] = '<>'
	vim.g['test#<>#executable'] = '<>'
]], {
    i(1, '<language>'), i(2, '<runner>'), l(l._1 .. '#' .. l._2, {1, 2}),
    i(3, '<path/to/executable>')
})))

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
	require('dap').configurations.python = {
		{
			type = 'python',
			request = 'launch',
			name = 'Launch current',
			program = '${file}', -- current file
			console = 'externalTerminal',
			pythonPath = os.getenv('VIRTUAL_ENV') .. '/bin/python'
		},
		{
			type = 'python',
			request = 'launch',
			name = 'Test current',
			code = 'import pytest; pytest.main(["${file}"])',
			console = 'externalTerminal',
			pythonPath = os.getenv('VIRTUAL_ENV') .. '/bin/python'
		}
	}
]], {})))

return M

-- vim: noet
