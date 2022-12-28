local M = {}

local function get_file_upper_camel()
    return require('utils').snake_to_upper_camel(vim.fn.expand('%:t:r'))
end

table.insert(M, s({trig = 'imp', dscr = 'Import'}, fmta([[
	import <>
]], {i(0)})))

table.insert(M, s({trig = 'c', dscr = 'Class'}, fmta([[
	class <>:
		<>
]], {i(1, get_file_upper_camel()), i(0)})))

table.insert(M, s({trig = 'en', dscr = 'Enum'}, fmta([[
	class <>(enum.Enum):
		<>
]], {i(1, get_file_upper_camel()), i(0)})))

table.insert(M, s({trig = 'f', dscr = 'Function'}, fmta([[
	def <>(<>):
		<>
]], {i(1, '__init__'), i(2, 'self'), i(0)})))

table.insert(M, s({trig = 'i', dscr = 'If'}, fmta([[
	if <>:
		<>
]], {i(1), i(0)})))

table.insert(M, s({trig = 'e', dscr = 'Else'}, fmta([[
	else:
		<>
]], {i(0)})))

table.insert(M, s({trig = 'ei', dscr = 'Else-if'}, fmta([[
	elif <>:
		<>
]], {i(1), i(0)})))

table.insert(M, s({trig = 's', dscr = 'Switch case'}, fmta([[
	match <>:
		case <>:
			<>
]], {i(1), i(2, '_'), i(0)})))

table.insert(M, s({trig = 'l', dscr = 'Loop (for)'}, fmta([[
	for <>:
		<>
]], {
    c(1, {
        fmta('<> in range(<>)', {i(1, 'i'), i(2, '10')}),
        fmta('<> in <>', {i(1, 'value'), i(2, 'lst')}),
        fmta('<>, <> in enumerate(<>)', {i(1, 'i'), i(2, 'value'), i(3, 'lst')}),
        fmta('<>, <> in <>.items()', {i(1, 'key'), i(2, 'value'), i(3, 'dct')}),
        fmta('<>, (<>, <>) in enumerate(<>.items())',
             {i(1, 'i'), i(2, 'key'), i(3, 'value'), i(4, 'dct')})
    }), i(0)
})))

table.insert(M, s({trig = 'lw', dscr = 'Loop (while)'}, fmta([[
	while <>:
		<>
]], {i(1), i(0)})))

table.insert(M, s({trig = 'r', dscr = 'Return'}, fmta([[
	return <>
]], {i(0)})))

table.insert(M, s({trig = '0', dscr = 'False'}, fmta([[
	False
]], {})))

table.insert(M, s({trig = '1', dscr = 'False'}, fmta([[
	True
]], {})))

table.insert(M, s({trig = 'p', dscr = 'Print (debug)'}, fmta([[
	print(<>)
]], {v(1)})))

table.insert(M, s({trig = 't', dscr = 'Try-catch'}, fmta([[
	try:
		<>
	except Exception as e:
]], {i(0)})))

table.insert(M, s({trig = 'err', dscr = 'Raise error'}, fmta([[
	raise <>
]], {i(0, 'Exception()')})))

table.insert(M, s({trig = 'v', dscr = 'Variable'}, fmta([[
	<> = <>
]], {i(1, 'var_a'), i(0, 'value')})))

return M
-- vim: noet
