local M = {}

table.insert(M,
             s(
                 {
        trig = '?lua/autocommand_new',
        dscr = 'Template for autocommand'
    }, fmta([[
	local group_name = '<>'
	vim.api.nvim_create_augroup(group_name, {clear = true})
	vim.api.nvim_create_autocmd('FileType', {
		pattern = '<>',
		callback = function() <> end,
		group = group_name
	})
	]], {i(1, 'group_name'), i(2, 'filetype'), i(0)}, {})))

table.insert(M,
             s({trig = '?lua/module', dscr = 'Template for Lua Module'},
               fmta([[
	local M = {}

	function M.setup()
		<>
	end

	return M
]], {i(0)})))

return M

-- vim: noet
