local M = {}

table.insert(M, s({trig = 'imp', dscr = 'Import'}, fmta([[
	local <> = require('<>')
]], {i(1, 'mod'), i(2, 'modname')})))

table.insert(M, s({trig = 'f', dscr = 'Function'}, fmta([[
	function <>(<>)
		<>
	end
]], {i(1, 'foo_bar'), i(2), i(0)})))

table.insert(M, s({trig = 'i', dscr = 'If'}, fmta([[
	if <> then
		<>
	end
]], {i(1), i(0)})))

table.insert(M, s({trig = 'e', dscr = 'Else'}, fmta([[
	else
		<>
]], {i(0)})))

table.insert(M, s({trig = 'ei', dscr = 'Else-if'}, fmta([[
	elseif <> then
		<>
]], {i(1), i(0)})))

table.insert(M, s({trig = 'l', dscr = 'Loop (for)'}, fmta([[
	for <> do
		<>
	end
]], {
    c(1, {
        fmta('i = <>, <>', {i(1, '1'), i(2, '10,1')}),
        fmta('<>, <> in ipairs(<>)', {i(1, 'i'), i(2, 'value'), i(3, 't')}),
        fmta('<>, <> in pairs(<>)', {i(1, 'key'), i(2, 'value'), i(3, 't')})
    }), i(0)
})))

table.insert(M, s({trig = 'lw', dscr = 'Loop (while)'}, fmta([[
	while (<>) do
		<>
	end
]], {i(1), i(0)})))

table.insert(M, s({trig = 'r', dscr = 'Return'}, fmta([[
	return <>
]], {i(0)})))

table.insert(M, s({trig = '0', dscr = 'False'}, fmta([[
	false
]], {})))

table.insert(M, s({trig = '1', dscr = 'True'}, fmta([[
	true
]], {})))

table.insert(M, s({trig = 'p', dscr = 'Print (debug)'}, fmta([[
	print(vim.inspect(<>))
]], {v(1)})))

table.insert(M, s({trig = 't', dscr = 'Try-catch'}, fmta([[
	xpcall(<>, function(err)
	end)
]], {i(0, 'foo')})))

table.insert(M, s({trig = 'err', dscr = 'Raise error'}, fmta([[
	error(<>)
]], {v(1)})))

table.insert(M, s({trig = 'v', dscr = 'Variable'}, fmta([[
	local <> = <>
]], {i(1, 'var_a'), i(0, 'value')})))
return M
-- vim: noet
