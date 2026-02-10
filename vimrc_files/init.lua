local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

require("common-utils").setup()
require("common-theme").setup()
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
})
