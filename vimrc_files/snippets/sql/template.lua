local M = {}

table.insert(
	M,
	s(
		{ trig = "----sql/insert", dscr = "Insert statement template" },
		fmta(
			[[
	
	INSERT INTO <><>
	VALUES
		(<>);
]],
			{ i(1, "table"), i(2, { "", "(columns)" }), i(0) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "----sql/delete_by_id", dscr = "Delete statement template" },
		fmta(
			[[
	DELETE FROM <> WHERE id = <>;
]],
			{ i(1, "table"), i(2, ":id") }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "----sql/update_by_id", dscr = "Update statement template" },
		fmta(
			[[
	UPDATE <> SET <> = <> WHERE id = <>;
]],
			{ i(1, "table"), i(2, "column"), i(3, "value"), i(4, ":id") }
		)
	)
)
return M
-- vim: noet
