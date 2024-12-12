local M = {}

function M.setup()
	require("dressing").setup({
		input = {
			win_options = { winblend = 15 },
			min_width = 40,
			mappings = {
				n = { ["<c-c>"] = "Close" },
				i = { ["<c-n>"] = "HistoryNext", ["<c-p>"] = "HistoryPrev" },
			},
		},
		select = {
			backend = { "fzf_lua" },
			fzf_lua = { winopts = { width = 0.4, height = 0.3 } },
		},
	})
	vim.cmd([[
        augroup Dressing
            autocmd!
            autocmd FileType DressingSelect nnoremap <buffer><silent><c-p> k
            autocmd FileType DressingSelect nnoremap <buffer><silent><c-n> j
            autocmd FileType DressingInput setlocal sidescrolloff=10
        augroup END
    ]])
end

return M
