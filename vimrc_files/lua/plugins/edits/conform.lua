local function setup()
	-- Formatting is opt-in per project: localvimrc sets require("conform").formatters_by_ft
	-- or enables a formatting-capable LSP (lsp_format = "fallback" uses the LSP then)
	require("conform").setup({
		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 500,
		},
	})
end

return {
	{
		-- https://github.com/stevearc/conform.nvim
		"stevearc/conform.nvim",
		config = setup,
	},
}
