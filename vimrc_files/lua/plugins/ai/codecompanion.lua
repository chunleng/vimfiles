local utils = require("common-utils")

local function setup()
	local codecompanion = require("codecompanion")
	codecompanion.setup({
		display = {
			action_palette = {
				provider = "default",
			},
		},
		interactions = {
			chat = {
				adapter = "claude_code",
				keymaps = {
					send = { modes = { n = "<c-cr>", i = "<c-cr>" } },
					stop = { modes = { n = "<c-c>", i = "<c-c>" } },
				},
				opts = {
					system_prompt = "",
				},
			},
		},
		extensions = {
			mcphub = {
				callback = "mcphub.extensions.codecompanion",
				opts = {
					make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
					show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
					add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
					format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
					show_result_in_chat = true, -- Show tool results directly in chat buffer
					make_vars = true, -- Convert MCP resources to #variables for prompts
					make_slash_commands = true, -- Add MCP prompts as /slash commands
				},
			},
		},
		adapters = {
			acp = {
				claude_code = function()
					return require("codecompanion.adapters").extend("claude_code", {
						env = {
							ANTHROPIC_API_KEY = "", -- Ensure no accidental use of API key
						},
					})
				end,
			},
		},
		rules = {
			default = {
				description = "Collection of common files for all projects",
				files = {
					{ path = "CLAUDE.md", parser = "claude" },
					{ path = ".vim/CLAUDE.md", parser = "claude" },
					{ path = "~/.claude/CLAUDE.md", parser = "claude" },
				},
				is_preset = true,
			},
			opts = {
				chat = {
					autoload = "default", -- The rule groups to load
					enabled = true,
				},
			},
		},
		-- NOTE: The log_level is in `opts.opts`
		opts = {
			log_level = "TRACE", -- or "TRACE"
		},
	})

	utils.keymap({ "n", "i" }, "<c-s-a>", function()
		codecompanion.toggle()
	end)

	local group_name = "lCodeCompanion"
	vim.api.nvim_create_augroup(group_name, { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "codecompanion",
		callback = function(opt)
			utils.buf_keymap(opt.buf, "n", "q", function()
				codecompanion.toggle()
			end)
		end,
		group = group_name,
	})
end

return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"ravitemer/mcphub.nvim",
	},
	version = "*",
	config = setup,
}
