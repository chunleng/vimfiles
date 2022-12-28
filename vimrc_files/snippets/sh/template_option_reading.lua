local M = {}

local function get_flags(str)
    local ret, i = {}, 1
    while (i < string.len(str) + 1) do
        if i < string.len(str) and str:sub(i + 1, i + 1) == ':' then
            table.insert(ret, str:sub(i, i) .. ':')
            i = i + 2
        else
            table.insert(ret, str:sub(i, i))
            i = i + 1
        end
    end
    return ret
end

table.insert(M,
             s(
                 {
        trig = 'template/sh/option_reading',
        dscr = 'Template for option reading'
    }, fmta([[
	show_usage(){
		cat <<<< EOF
	Name of Application, v1.0
	<>

	usage: $0 [-options] non-options-value

	Where options include:
		-h          show this help<>
	EOF
	}

	# initialize getopts index
	OPTIND=1

	while getopts ":h<>" opt; do
		case "$opt" in<>
			?)
				echo "Unknown option: -$OPTARG" >>&2;
				show_usage
				exit
				;;
			:)
				echo "Missing option argument for -$OPTARG" >>&2
				show_usage
				exit
				;;
		esac
	done

	shift $((OPTIND-1))

	# For removing double dash in option
	test "$1" = "--" && shift
]], {
        i(0, '[Description of application here]'), d(2, function(args)
            local flags = get_flags(args[1][1])

            for i = 1, #flags do
                flags[i] = string.format('-%-9s  [Description of this option]',
                                         flags[i]:gsub(':', ' <value>'))
            end

            if #flags > 0 then
                -- Add new line if flags available
                table.insert(flags, 1, '')
            end

            return isn(nil, {t(flags)}, '$PARENT_INDENT\t')
        end, {1}), i(1, 'a:bc:'), d(3, function(args)
            local flags = get_flags(args[1][1])
            -- Add new line if flags available
            local lines = #flags == 0 and {} or {''}
            for i = 1, #flags do
                table.insert(lines, flags[i]:sub(1, 1) .. ')')
                if string.find(flags[i], ':') then
                    table.insert(lines, string.format('\techo "%s ${OPTARG}"',
                                                      flags[i]:sub(1, 1)))
                else
                    table.insert(lines, string.format('\techo "%s"',
                                                      flags[i]:sub(1, 1)))
                end
                table.insert(lines, '\t;;')
            end
            return isn(nil, {t(lines)}, '$PARENT_INDENT\t\t')
        end, {1})
    })))
-- try:
--	 snip.shift(2)
--	 snip.rv += ""

--	 i=0
--	 while i < len(t[2]):
--		 snip += t[2][i] + ")"
--		 snip.shift(1)
--		 if i != len(t[2])-1 and t[2][i+1] == ':':
--			 snip += "echo \"" + t[2][i] + " ${OPTARG}\""
--			 i += 1
--		 else:
--			 snip += "echo \"" + t[2][i] + "\""
--		 snip += ";;"
--		 i+=1
--		 snip.unshift(1)
-- except:
--	 exit
-- `
return M
-- vim: noet
