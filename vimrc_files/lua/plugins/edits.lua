return {
	{
		dir = vim.fn.stdpath("config") .. "/lua/plugins/edits",
		dependencies = {
			{ import = "plugins.edits.surround" },
			{ import = "plugins.edits.comment" },
			{ import = "plugins.edits.visual_multi" },
		},
	},
}
