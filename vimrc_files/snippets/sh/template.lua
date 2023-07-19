local M = {}

table.insert(M, s({
    trig = '?sh/app_path',
    dscr = 'Template for variable that returns the APP_PATH'
}, fmta([[
    APP_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd  )"
]], {})))

table.insert(M,
             s(
                 {
        trig = '?sh/short_input',
        dscr = 'Template for a short input'
    }, fmta([[
	read -r -p "<>? [y/N]" -n 1 response
	echo
	case $response in
	  [yY]) <>;;
	  *) <>;;
	esac
]], {i(0), i(1, 'func_a'), i(2, 'func_b')})))

table.insert(M, s({trig = '?sh/default_variable', dscr = 'Template for calling variable with default value if not already set'}, fmta([[
	: ${<>="<>"}
]], {i(1, 'VAR_NAME'), i(2, 'value')})))

return M
-- vim: noet
