local M = {}

local function s_if_main(trig)
    return s({trig = trig, dscr = 'Template for main function'}, fmta([[
		if __name__ == '__main__':
			<>
	]], {i(0)}))
end

table.insert(M, s_if_main('i/main'))
table.insert(M, s_if_main('template/if_main'))

table.insert(M, s({
    trig = 'template/googlestyle_module_docstring',
    dscr = 'Template for Google style module docstring'
}, fmta([[
"""A one line summary of the module or program, terminated by a period.

Leave one blank line. The rest of this docstring should contain an
overall description of the module or program.  Optionally, it may alsd
contain a brief description of exported classes and functions and/or usage
examples.

	Typical usage example:

	foo = ClassFoo()
	bar = foo.FunctionBar()
"""
]], {})))

table.insert(M, s({
    trig = 'template/googlestyle_class_docstring',
    dscr = 'Template for Google style function docstring'
}, fmta([[
"""Summary of class here.

Longer class information...

Attributes:
    likes_spam: A boolean indicating if we like SPAM or not.
	eggs: An integer count of the eggs we have laid.
"""

]], {})))

table.insert(M, s({
    trig = 'template/googlestyle_function_docstring',
    dscr = 'Template for Google style function docstring'
}, fmta([[
"""${1:Fetches rows from a Smalltable.}

${2:Retrieves rows pertaining to the given keys from the Table instance
represented by table_handle.  String keys will be UTF-8 encoded.}

Args:
	keys: A sequence of strings representing the key of each table
		row to fetch.  String keys will be UTF-8 encoded.

Returns:
	string

	A dict mapping keys to the corresponding table row data
	fetched. Each row is represented as a tuple of strings. For
	example:

	{b'Serak': ('Rigel VII', 'Preparer'),
	 b'Zim': ('Irk', 'Invader'),
	 b'Lrrr': ('Omicron Persei 8', 'Emperor')}

Raises:
	IOError: An error occurred accessing the smalltable.
"""
]], {})))

return M
-- vim: noet
