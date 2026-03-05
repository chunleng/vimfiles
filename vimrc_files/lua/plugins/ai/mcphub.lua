local constant = require("constant")
local utils = require("common-utils")

local function build(plugin)
	local orig_nodejs_version = os.getenv("ASDF_NODEJS_VERSION")
	vim.env.ASDF_NODEJS_VERSION = constant.NODEJS_VERSION
	-- Replacing the recommended command with following
	--     dofile(plugin.dir .. "/bundled_build.lua")
	-- This is due to issue with version mismatch: https://github.com/ravitemer/mcphub.nvim/issues/239
	-- And it's better to control the version of package install instead of using the latest
	local bundled = plugin.dir .. "/bundled/mcp-hub"
	vim.fn.mkdir(bundled, "p")
	vim.system({ "npm", "init", "-y" }, { cwd = bundled, text = true })
	vim.system({ "npm", "install", "mcp-hub@4.2.1" }, { cwd = bundled, text = true })
	vim.env.ASDF_NODEJS_VERSION = orig_nodejs_version
end

local function setup(plugin)
	local mcp_json = vim.fn.fnamemodify(utils.find_file_upwards(".vim/mcp.json"), ":.")
	require("mcphub").setup({
		cmd = constant.NODEJS_PATH .. "/node",
		cmdArgs = { plugin.dir .. "/bundled/mcp-hub/node_modules/mcp-hub/dist/cli.js" },
		config = vim.fn.expand("~/.mcp.json"),
		workspace = {
			enabled = true,
			look_for = { mcp_json },
		},
	})
end
return {
	{
		-- https://github.com/ravitemer/mcphub.nvim
		-- https://github.com/nvim-lua/plenary.nvim
		{
			-- TODO Change back when PR is merged https://github.com/ravitemer/mcphub.nvim/pull/279
			-- "ravitemer/mcphub.nvim",
			"bahaaza/mcphub.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			build = build,
			config = setup,
		},
	},
}
