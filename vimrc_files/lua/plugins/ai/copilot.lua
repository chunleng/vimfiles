local constant = require("constant")
local function setup()
	vim.g.copilot_filetypes = {
		["*"] = false, -- Disabling for all because we are using for authentication purpose
	}
	vim.g.copilot_no_tab_map = true
	vim.g.copilot_node_command = constant.NODEJS_PATH .. "/node"
	vim.g.copilot_npx_command = constant.NODEJS_PATH .. "/lib/node_modules/npm/bin/npx"
end

return {
	{
		-- https://github.com/github/copilot.vim
		"github/copilot.vim",
		config = setup,
	},
}
