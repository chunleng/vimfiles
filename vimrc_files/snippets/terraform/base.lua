local M = {}

table.insert(M, s({trig = 'p', dscr = 'Print'}, fmta([[
	output "<>" {
		value = <>
	}
]], {i(1, 'foo_a'), i(0)})))

table.insert(M, s({trig = '?', dscr = 'Ternary if'}, fmta([[
	<> ? <> : <>
]], {i(1, 'var.var_a'), i(2, 'a'), i(0, 'b')})))

table.insert(M, s({trig = 'a', dscr = 'Short-circuit and'}, fmta([[
	&&
]], {})))

table.insert(M, s({trig = 'o', dscr = 'Short-circuit or'}, fmta([[
	||
]], {})))

table.insert(M, s({trig = 'no', dscr = 'Not equal'}, fmta([[
	!=
]], {})))

table.insert(M, s({trig = 'l', dscr = 'Loop'}, c(1, {
    fmta('for_each = <>', {i(1, '[] # to use: each.key, each.value')}),
    fmta('count = <>', {i(1, 'length(var.var_a) # to use: count.index')})
})))

table.insert(M, s({trig = 'lc', dscr = 'List comprehension'}, fmta([[
	[for <> in <> : <>]
]], {
    i(1, 'i, value'), i(2, 'var.lst'), i(3, '"test_${value}" if value != "foo"')
})))

table.insert(M, s({trig = 'F', dscr = 'False'}, fmta([[
	false
]], {})))

table.insert(M, s({trig = 'T', dscr = 'True'}, fmta([[
	true
]], {})))

return M
-- vim: noet
