local M = {}

table.insert(M, s({
    trig = 'template/sh/app_path',
    dscr = 'Template for variable that returns the APP_PATH'
}, fmta([[
    APP_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd  )"
]], {})))

table.insert(M,
             s(
                 {
        trig = 'template/sh/short_input',
        dscr = 'Template for a short input'
    }, fmta([[
	read -r -p "<>? [y/N]" -n 1 response
	echo
	case $response in
	  [yY]) <>;;
	  *) <>;;
	esac
]], {i(0), i(1, 'func_a'), i(2, 'func_b')})))

return M
-- vim: noet
