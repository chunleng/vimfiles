local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

local function setup()
	require("mod.setup_action_palette")
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
