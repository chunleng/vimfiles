local M = {}

table.insert(M,
             s(
                 {
        trig = '?rust/cargo_init_workspace',
        dscr = 'Template for Cargo workspace'
    }, fmta([[
[workspace]

members = [
	"<>"
]
]], {i(1, 'path/to/member')})))

return M
-- vim: noet
