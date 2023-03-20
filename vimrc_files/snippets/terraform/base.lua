local M = {}

table.insert(M, s({trig = 'p', dscr = 'Print'}, fmta([[
	output "<>" {
		value = <>
	}
]], {i(1, 'foo_a'), i(0)})))

table.insert(M, s({trig = '?', dscr = 'Ternary if'}, fmta([[
	<> ? <> : <>
]], {i(1, 'var.var_a'), i(2, 'a'), i(0, 'b')})))

table.insert(M, s({trig = 'o', dscr = 'Short-circuit or'}, t('|| ')))
table.insert(M, s({trig = 'a', dscr = 'Short-circuit and'}, t('&& ')))
table.insert(M, s({trig = 'ne', dscr = 'Not equal'}, t('!= ')))

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

table.insert(M, s({trig = 'variable', dscr = 'Terraform variable'}, fmta([[
	variable "<>" {
		type = string
		description = "<>"
	}
]], {i(1, 'foo'), i(2, 'Description of the variable')})))

table.insert(M, s({trig = 'resource', dscr = 'Terraform resource'}, fmta([[
	resource "<>" "<>" {
		<>
	}
]], {i(1, 'resource_type'), i(2, 'resource-name'), i(0)})))

table.insert(M, s({trig = 'data', dscr = 'Terraform data'}, fmta([[
	data "<>" "<>" {
		<>
	}
]], {i(1, 'data_type'), i(2, 'data-name'), i(0)})))

return M
-- vim: noet
