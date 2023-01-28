local M = {}

local function s_details(trig)
    return s({trig = trig, dscr = 'Template for commonly used <details> tag'},
             fmt([[
    <details>
    <summary>{}</summary>

    ```{}
    {}
    ```

    </details>
]], {i(1), i(2), i(0)}))
end
table.insert(M, s_details('<details>'))
table.insert(M, s_details('?details'))

table.insert(M,
             s(
                 {
        trig = '?user_story',
        dscr = 'Template for writing a user story'
    }, fmta([[
	snippet __user_story "Description" b
	# Description

	As a <>
	I want to <>
	so that <>

	# Acceptance Criteria

	- <>
]], {
        i(1, 'role/profile'), i(2, 'action/activity'), i(3, 'benefit/reason'),
        i(0)
    })))

return M
-- vim: noet
