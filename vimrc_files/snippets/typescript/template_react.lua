local M = {}

local function f_lower_to_upper_camel(args)
    return require('utils').snake_to_upper_camel(args[1][1])
end

table.insert(M,
             s({trig = '?react/module', dscr = 'Template for new React module'},
               fmta([[
	import { ReactElement } from "react";

	type <>Props = {
		
	};

	export default function <>({  }: <>Props): ReactElement {
		return (
			<<>>
				<>
			<</>>
		);
	}

]], {l(l._1, 1), i(1, "Foo"), l(l._1, 1), i(0)})))

table.insert(M,
             s(
                 {
        trig = '?react/function',
        dscr = 'Template for new React function'
    }, fmta([[
	function <>(): ReactElement {
		return (
			<>
		)
	}
]], {i(1, "Foo"), i(0, "<></>")})))

table.insert(M,
             s({trig = '?react/useState', dscr = 'Template for React useState'},
               fmta([[
	const [<>, set<>] = useState<<<>>>(<>)
]], {i(1, "foo"), f(f_lower_to_upper_camel, {1}), i(2, "string"), i(3)})))

table.insert(M,
             s(
                 {
        trig = '?react/useEffect',
        dscr = 'Template for React useEffect'
    }, fmta([[
	useEffect(() =>> {
		<>
	}, [<>])
]], {v(1), i(2)})))

return M
-- vim: noet
