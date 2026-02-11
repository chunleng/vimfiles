local function setup()
	local utils = require("common-utils")
	utils.keymap("n", "<leader>tc", "<cmd>ColorizerToggle<cr>")
	require("colorizer").setup({ user_default_options = { names = false } })
end

return {
	{
		-- https://github.com/NvChad/nvim-colorizer.lua
		"NvChad/nvim-colorizer.lua",
		config = setup,
	},
}
