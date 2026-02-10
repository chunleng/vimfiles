local ft = { "markdown", "plantuml" }

local function build()
	vim.fn["mkdp#util#install"]()
end

local function setup()
	local group_name = "MarkdownPreview"
	vim.api.nvim_create_augroup(group_name, { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "markdown",
		callback = function()
			local utils = require("common-utils")
			utils.buf_keymap(0, { "n" }, "<leader>tm", "<cmd>MarkdownPreviewToggle<cr>", { silent = true })
		end,
		group = group_name,
	})
	vim.g.mkdp_auto_close = 0
	vim.g.mkdp_filetypes = ft
end

return {
	{
		-- https://github.com/iamcco/markdown-preview.nvim
		"iamcco/markdown-preview.nvim",
		build = build,
		config = setup,
		ft = ft,
	},
}
