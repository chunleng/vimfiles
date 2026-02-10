local function setup()
	vim.cmd([[
    augroup fenced_code_block
        autocmd!
        autocmd FileType markdown nnoremap <buffer> <silent> <leader>cgf :E<cr>
    augroup END
    ]])
end

return {
	{
		-- https://github.com/amiorin/vim-fenced-code-blocks
		-- https://github.com/nvim-treesitter/nvim-treesitter
		"amiorin/vim-fenced-code-blocks",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = setup,
		ft = { "markdown" },
	},
}
