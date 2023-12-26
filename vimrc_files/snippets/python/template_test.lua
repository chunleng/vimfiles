local M = {}

table.insert(M,
             s(
                 {
        trig = '?python/pytest/fixture',
        dscr = 'Pytest fixture template'
    }, fmta([[
	@pytest.fixture
	def <>_mock():
	    yield <>
]], {i(1, 'foo'), i(0)})))

table.insert(M, s({
    trig = '?python/pytest/fixture_mock',
    dscr = 'Pytest fixture with mock template'
}, fmta([[
	@pytest.fixture
	def <>_mock():
		with mock.patch('<>') as mck:
			yield mck
]], {i(1, 'foo'), i(0, 'path.to.code')})))

return M
-- vim: noet
