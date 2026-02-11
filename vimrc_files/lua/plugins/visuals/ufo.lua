local function setup()
	vim.o.foldlevel = 99
	vim.o.foldlevelstart = 99
	require("ufo").setup()
end

return {
	{
		-- Handle folding
		-- https://github.com/kevinhwang91/nvim-ufo.git
		-- https://github.com/kevinhwang91/promise-async
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		config = setup,
	},
}
