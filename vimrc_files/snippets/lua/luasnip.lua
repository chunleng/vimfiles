local M = {}

table.insert(M, s({trig = 'ss', dscr = 'Snippet'}, fmta([=[
	table.insert(M, s({trig = '<>', dscr = '<>'}, fmta([[
		<>
	]], {})))
]=], {i(1), i(2), i(0)})))

table.insert(M,
             s(
                 {
        trig = '?luasnip/module',
        dscr = 'Template for luasnip module'
    }, fmta([[
	local M = {}

	<>

	return M
	-- vim: noet
]], {i(0)})))

table.insert(M, s({trig = 'sf', dscr = 'Function'}, fmta([[
	f(function(_, snip)
		<>
	end, {})
]], {i(0)})))
return M

-- vim: noet
