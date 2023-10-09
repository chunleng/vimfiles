local M = {}

local function get_file_upper_camel(_, snip)
    snip = snip.snippet or snip
    return sn(nil, {
        i(1, require('utils').snake_to_upper_camel(
              snip.env.TM_FILENAME:match("^(.+)%..+$")))
    })
end

local struct_template = fmta([[
	struct <> {
		<>
	}
	]], {d(1, get_file_upper_camel, {}), i(2, "attr_a: String")})

table.insert(M, s({trig = 'imp', dscr = 'Import'}, fmta([[
	use <>;<>
]], {i(1, "std::println"), i(0)})))

table.insert(M, s({trig = 'm', dscr = 'Module'}, fmta([[
	mod <> {
		<>
	}
]], {d(1, get_file_upper_camel, {}), i(0)})))

table.insert(M, s({trig = 'c', dscr = 'Class'}, struct_template))

table.insert(M, s({trig = 'en', dscr = 'Enum'}, fmta([[
	enum <> {
		<>
	}
]], {d(1, get_file_upper_camel, {}), i(0, {"FOO_BAR", "\tBAZ"})})))

table.insert(M, s({trig = 'if', dscr = 'Interface'}, c(1, {
    fmta([[
	trait <> {
		<>
	}
]], {d(1, get_file_upper_camel, {}), i(0, "fn func_name() -> String;")}),
    struct_template
})))

table.insert(M, s({trig = 'f', dscr = 'Function'}, fmta([[
	fn <>(<>)<> {
		<>
	}
]], {i(1, "func_name"), i(2, "arg_a: &str"), i(3, " -> String"), i(0)})))

table.insert(M, s({trig = 'fx', dscr = 'Lambda Function'}, fmta([[
	|<>|<> { <> }
]], {i(1, 'i: i32'), i(2, '-> i32'), i(0, 'i + 1')})))

table.insert(M, s({trig = '?', dscr = 'Ternary if'}, c(1, {
    fmta([[
	match <> {
		<> =>> 1,
		_ =>> 2
	}
]], {i(1, 'var_a'), i(2, 'var_b')}),
    fmta('if <> { <> } else <>', {i(1, 'x > 0'), i(2, 'var_a'), i(3, 'var_b')})
})))

table.insert(M, s({trig = 'i', dscr = 'If'}, fmta([[
	if <> {
		<>
	}
]], {i(1, 'x > 0'), i(0)})))

table.insert(M, s({trig = 'e', dscr = 'Else'}, fmta([[
	} else {
		<>
]], {i(0)})))

table.insert(M, s({trig = 'ei', dscr = 'Else-if'}, fmta([[
	else if <> {
		<>
]], {i(1), i(0)})))

table.insert(M, s({trig = 'o', dscr = 'Short-circuit or'}, t('|| ')))
table.insert(M, s({trig = 'a', dscr = 'Short-circuit and'}, t('&& ')))
table.insert(M, s({trig = 'n', dscr = 'Boolean not'}, t('!')))
table.insert(M, s({trig = 'ne', dscr = 'Not equal'}, t('!= ')))

table.insert(M, s({trig = 's', dscr = 'Switch case'}, fmta([[
	match <> {
		<> =>> 1,
		_ =>> 2
	}
]], {i(1, 'var_a'), i(0, 'var_b')})))

table.insert(M, s({trig = 'l', dscr = 'Loop (for)'}, fmta([[
	for <> {
		<>
	}
]], {
    c(1, {
        fmta('<> in <>', {i(1, 'value'), i(2, 'lst')}),
        fmta('<> in <>..<>', {i(1, 'i'), i(2, '1'), i(3, '11')})
    }), i(0)
})))

table.insert(M, s({trig = 'lw', dscr = 'Loop (while)'}, fmta([[
	while <> {
		<>
	}
]], {i(1, "x > 0"), i(0)})))

table.insert(M, s({trig = 'r', dscr = 'Return'}, fmta([[
	return <>;<>
]], {v(1), i(0)})))

table.insert(M, s({trig = 'F', dscr = 'False'}, t('false')))
table.insert(M, s({trig = 'T', dscr = 'True'}, t('true')))
table.insert(M, s({trig = 'N', dscr = 'Null'}, t('None')))

table.insert(M, s({trig = 'p', dscr = 'Print (debug)'}, fmta([[
	println!(<>);<>
]], {v(1, '"{}", 1'), i(0)})))

table.insert(M, s({trig = 'err', dscr = 'Raise error'}, fmta([[
	panic!(<>);<>
]], {i(1, '"Something Wrong"'), i(0)})))

table.insert(M, s({trig = 'v', dscr = 'Variable'}, fmta([[
	let <> = <>;<>
]], {
    c(1, {i(1, 'var_a: i32'), fmt('mut {}', {i(1, 'var_a')})}), i(2, 'value'),
    i(0)
})))

table.insert(M, s({trig = 'V', dscr = 'Constant'}, fmta([[
	const <> = <>;<>
]], {i(1, 'CONST_A: i32'), i(2, 'value'), i(0)})))

return M
-- vim: noet
