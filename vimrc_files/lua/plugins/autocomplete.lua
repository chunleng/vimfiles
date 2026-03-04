return {
	{
		dir = vim.fn.stdpath("config") .. "/lua/plugins/autocomplete",
		dependencies = {
			{ import = "plugins.autocomplete.luasnip" },
			{ import = "plugins.autocomplete.neogen" },
			{ import = "plugins.autocomplete.blink_cmp" },
		},
	},
}
