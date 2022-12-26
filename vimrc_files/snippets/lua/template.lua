local M = {}

table.insert(M,
             s(
                 {
        trig = 'template/autocommand_new',
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
	print(vim.inspect(<><>))
]], {i(1), f(function(_, snip) return snip.env.LS_SELECT_RAW end)})))

table.insert(M,
             s({trig = 'template/lua/module', dscr = 'Template for Lua Module'},
               fmta([[
	local M = {}

	function M.setup()
		<>
	end

	return M
]], {i(0)})))
return M

-- vim: noet
