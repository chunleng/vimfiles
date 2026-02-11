local function setup()
	require("dressing").setup({
		input = {
			win_options = { winblend = 15 },
			min_width = 40,
			mappings = {
				n = { ["<c-c>"] = "Close" },
				i = { ["<c-n>"] = "HistoryNext", ["<c-p>"] = "HistoryPrev" },
			},
		},
	})
	vim.cmd([[
        augroup Dressing
            autocmd!
            autocmd FileType DressingInput setlocal sidescrolloff=10
        augroup END
    ]])
end

return {
	{
		-- https://github.com/stevearc/dressing.nvim
		"stevearc/dressing.nvim",
		config = setup,
	},
}
