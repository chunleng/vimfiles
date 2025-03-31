local M = {}

local function get_file_upper_camel(_, snip)
	return sn(nil, {
		i(1, require("utils").snake_to_upper_camel(snip.env.TM_FILENAME:match("^(.+)%..+$"))),
	})
end

table.insert(
	M,
	s(
		{
			trig = "----python/pytest/fixture",
			dscr = "Pytest fixture template",
		},
		fmta(
			[[
	@pytest.fixture
	def <>_mock():
	    yield <>
]],
			{ i(1, "foo"), i(0) }
		)
	)
)

table.insert(
	M,
	s(
		{
			trig = "----python/pytest/fixture_mock",
			dscr = "Pytest fixture with mock template",
		},
		fmta(
			[[
	@pytest.fixture
	def <>_mock():
		with mock.patch('<>') as mck:
			yield mck
]],
			{ i(1, "foo"), i(0, "path.to.code") }
		)
	)
)

table.insert(
	M,
	s(
		{
			trig = "----python/unittest/class",
			dscr = "Template for Unittest",
		},
		fmta(
			[[
	class <>:
		def setup_method(self):
			<>

		def tear_method(self):
			pass
]],
			{ d(1, get_file_upper_camel, {}), i(0, "pass") }
		)
	)
)

table.insert(
	M,
	s(
		{
			trig = "----python/unittest/function",
			dscr = "Template for Unittest",
		},
		fmta(
			[[
	def test_<>():
		<>
]],
			{ i(1, "func"), i(0, "pass") }
		)
	)
)
return M
-- vim: noet
