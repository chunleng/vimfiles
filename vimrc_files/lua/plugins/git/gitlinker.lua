local function setup()
	require("gitlinker").setup({
		router = {
			browse = {
				[".*"] = require("gitlinker.routers").github_browse,
			},
			blame = {
				[".*"] = require("gitlinker.routers").github_blame,
			},
		},
	})
end

return {
	{
		-- https://github.com/linrongbin16/gitlinker.nvim
		"linrongbin16/gitlinker.nvim",
		version = "*",
		config = setup,
		keys = {
			{ "<leader>gf", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Open git link" },
		},
	},
}
