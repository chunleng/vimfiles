return {
	{
		dir = vim.fn.stdpath("config") .. "/lua/plugins/html",
		dependencies = {
			{ import = "plugins.html.ts_autotag" },
		},
		ft = { "html", "javascriptreact", "typescriptreact", "rust" },
	},
}
