local M = {}

local function zet_header(tags)
	tags = tags and tags or {}
	return sn(
		nil,
		fmta(
			[[
        # <>

        - created on: <>
        - tags: #<>

        ----

        ## Main
    ]],
			{
				f(function(_, snip)
					local filename = snip.snippet.env.TM_FILENAME:gsub(".[^.]+$", "")
					return table.concat(require("utils").title_case(vim.split(filename, "_")), " ")
				end, {}),
				f(function(_, _)
					return os.date("%Y-%m-%d %X")
				end),
				t(table.concat(tags, ", #")),
			}
		)
	)
end

local function zet_footer()
	return sn(
		nil,
		fmta(
			[[
        ----

        ## References
    ]],
			{}
		)
	)
end

table.insert(
	M,
	s(
		{ trig = "?notes", dscr = "Template for notes" },
		fmta(
			[[
	<>

	<>

	<>
]],
			{ zet_header(), i(0), zet_footer() }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "?notes/writing_idea", dscr = "Template for writing" },
		fmta(
			[[
    <>

    ### Motivation for this writing

    I wanted to write this article because <>

    By writing this article

    ### Research

    ### Candidate for Title

    ### Outline

    - [Topic 1]

    ### Other Notes

    ### Draft

    <>
]],
			{ zet_header(), i(0), zet_footer() }
		)
	)
)

table.insert(
	M,
	s(
		{
			trig = "?notes/cooking_recipe",
			dscr = "Template for cooking recipe",
		},
		fmta(
			[[
	<>

	[Image goes here]

	### Serving Size

	3 pax

	### Preparation Time

	X minutes before serving

	### Ingredients

	- Chicken, 1 whole

	### Steps

	#### Subsection 1 (e.g. fish)

	1.

	#### Putting it together

	1.

	<>
]],
			{ zet_header({ "cooking-recipe" }), zet_footer() }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "?notes/journal", dscr = "Template for journal writing" },
		fmta(
			[[
	<>

	### Goal Update

	<>

	### Summary of Feeling

	I feel 

	### Things That I am Grateful for

	-

	### 3 Main Events of the Day

	1.
	2.
	3.

	### What Worked

	- 

	### What Didn't Work

	- 

	<>
]],
			{ zet_header({}), i(0), zet_footer() }
		)
	)
)

table.insert(
	M,
	s(
		{
			trig = "?notes/relation",
			dscr = "Template for relationship management",
		},
		fmta(
			[[
	<>

	### Like

	- <>

	### Dislike

	- ...

	### Others

	- ...

	<>
]],
			{ zet_header({ "relation" }), i(0, "..."), zet_footer() }
		)
	)
)

return M
-- vim: noet
