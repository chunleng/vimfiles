local ft = {
	"markdown",
	"text",
	"gitcommit",
	"scratch",
}

local function setup()
	vim.g.bullets_enabled_file_types = ft
	vim.g.bullets_enable_in_empty_buffers = 0
	vim.g.bullets_set_mappings = 0
	vim.g.bullets_custom_mappings = {
		{ "nnoremap", "o", "<plug>(bullets-newline)" },
		{ "inoremap", "<c-d>", "<plug>(bullets-promote)" },
		{ "nnoremap", "<<", "<plug>(bullets-promote)" },
		{ "vnoremap", "<", "<plug>(bullets-promote)" },
		{ "inoremap", "<c-t>", "<plug>(bullets-demote)" },
		{ "nnoremap", ">>", "<plug>(bullets-demote)" },
		{ "vnoremap", ">", "<plug>(bullets-demote)" },
	}
end

return {
	{
		-- https://github.com/dkarter/bullets.vim
		"dkarter/bullets.vim",
		init = setup,
		ft = ft,
	},
}
