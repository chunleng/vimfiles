local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

local function setup()
	require("plugins._common.action_palette")
	require("plugins._common.enter_key_by_context")
	require("plugins._common.goto_file")
	require("plugins._common.quick_access")
end

require("common-utils").setup()
require("common-theme").setup()
require("lazy").setup({
	change_detection = { enabled = true, notify = false },
	spec = {
		{
			dir = vim.fn.stdpath("config") .. "/lua/plugins",
			dependencies = {
				{ import = "plugins" },
			},
			config = setup,
		},
	},
})
