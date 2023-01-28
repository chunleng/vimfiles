local M = {}

table.insert(M, s({trig = 'imp', dscr = 'Import'}, fmta([[
    source <>
]], {i(0)})))

table.insert(M, s({trig = 'f', dscr = 'Function'}, fmta([[
    function <> {
        <>
    }
]], {i(1, 'func_a'), i(0)})))

table.insert(M, s({trig = 'i', dscr = 'If'}, fmta([[
	if [ <> ]; then
		<>
	fi
]], {i(1), i(0)})))

table.insert(M, s({trig = 'e', dscr = 'Else'}, fmta([[
	else
		<>
]], {i(0)})))

table.insert(M, s({trig = 'ei', dscr = 'Else-if'}, fmta([[
	elif [ <> ]; then
		<>
]], {i(1), i(0)})))

table.insert(M, s({trig = 's', dscr = 'Switch-case'}, fmta([[
	case <> in
		<>)
			<>
			;;
	esac
]], {i(1, '$var_a'), i(2, '*'), i(0)})))

table.insert(M, s({trig = 'l', dscr = 'Loop (for)'}, fmta([[
	for <>; do
		<>
	done
]], {
    c(1, {
        fmta('<> in {<>..<>}', {i(1, 'i'), i(2, '1'), i(3, '10..1')}),
        fmta('<> in <>', {i(1, 'i'), i(2)})
    }), i(0)
})))

table.insert(M, s({trig = 'lw', dscr = 'Loop (while)'}, fmta([[
	while [ <> ]; do
		<>
	done
]], {i(1), i(0)})))

table.insert(M, s({trig = 'F', dscr = 'False'}, fmta([[
	false
]], {})))

table.insert(M, s({trig = 'T', dscr = 'True'}, fmta([[
	true
]], {})))

table.insert(M, s({trig = 'p', dscr = 'Print (debug)'}, fmta([[
	echo <>
]], {i(0)})))

table.insert(M, s({trig = 'v', dscr = 'Variable'}, c(1, {
    fmta([[
	export <>=<>
]], {i(1, 'var_a'), i(2, 'value')}), fmta([[
	: ${<>=<>}
]], {i(1, 'VAR_A'), i(2, value)})
})))

table.insert(M, s({trig = '#!', dscr = 'Shell bang'}, fmta([[
#!/usr/bin/env bash

set -eu

<>
]], {i(0)})))

return M
-- vim: noet
