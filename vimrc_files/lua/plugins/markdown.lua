return {
	{
		dir = vim.fn.stdpath("config") .. "/lua/plugins/markdown",
		dependencies = {
			{ import = "plugins.markdown.bullets" },
			{ import = "plugins.markdown.markdown_preview" },
			{ import = "plugins.markdown.fenced_code_block" },
		},
	},
}
