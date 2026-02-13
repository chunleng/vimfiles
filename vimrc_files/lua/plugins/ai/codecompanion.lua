local utils = require("common-utils")
local tool_execution_precheck = require("mod.codecompanion.tool_execution_precheck")
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
				adapter = {
					name = "copilot",
					model = "gpt-4.1",
				},
				keymaps = {
					send = { modes = { n = "<c-cr>", i = "<c-cr>" } },
					stop = { modes = { n = "<c-c>", i = "<c-c>" } },
				},
				tools = {
					memory = { opts = { require_approval_before = false } },
					file_search = {
						callback = require("mod.codecompanion.fd_search"),
					},
					grep_search = { opts = { require_approval_before = false } },
					read_file = {
						callback = tool_execution_precheck.wrap(
							require("codecompanion.interactions.chat.tools.builtin.read_file"),
							function(_, args, _)
								return tool_execution_precheck.validate_in_cwd(args.filepath)
							end
						),
						opts = {
							require_approval_before = false,
						},
					},
					insert_edit_into_file = {
						callback = tool_execution_precheck.wrap(
							require("codecompanion.interactions.chat.tools.builtin.insert_edit_into_file"),
							function(_, args, _)
								return tool_execution_precheck.validate_in_cwd(args.filepath)
							end
						),
						opts = {
							require_confirmation_after = false,
						},
					},
					create_file = {
						-- Not too different with insert_edit_into_file, so diasbling it
						enabled = false,
					},
					delete_file = {
						callback = tool_execution_precheck.wrap(
							require("codecompanion.interactions.chat.tools.builtin.delete_file"),
							function(_, args, _)
								return tool_execution_precheck.validate_in_cwd(args.filepath)
							end
						),
						opts = {
							require_approval_before = false,
						},
					},
					groups = {
						read_only = {
							description = "Tools related to reading files",
							prompt = "I'm giving you access to ${tools} to help you perform read-only file operations",
							tools = { "file_search", "get_changed_files", "grep_search", "read_file" },
						},
						web = {
							description = "Tools related to web access",
							prompt = "I'm giving you access to ${tools} to help you perform operations on the web",
							tools = { "web_search", "fetch_webpage" },
						},
						files = {
							tools = {
								"insert_edit_into_file",
								"delete_file",
								"file_search",
								"get_changed_files",
								"grep_search",
								"read_file",
							},
						},
					},
					opts = {
						default_tools = { "read_only" },
						system_prompt = {
							enabled = false,
						},
					},
				},
				opts = {
					system_prompt = "",
				},
			},
			inline = {
				keymaps = {
					accept_change = { modes = { n = "<cr>" } },
					reject_change = { modes = { n = "<esc>" } },
					always_accept = { modes = { n = "<c-cr>" } },
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
			http = {
				tavily = function()
					return require("codecompanion.adapters").extend("tavily", {
						env = {
							api_key = vim.fn.getenv("TAVILY_API_KEY"),
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
