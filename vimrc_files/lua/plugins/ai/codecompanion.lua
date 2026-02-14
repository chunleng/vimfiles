local utils = require("common-utils")
local tool_execution_precheck = require("mod.codecompanion.tool_execution_precheck")

local function get_open_chats()
	local codecompanion = require("codecompanion")
	local loaded_chats = codecompanion.buf_get_chat()
	local open_chats = {}

	for _, data in ipairs(loaded_chats) do
		table.insert(open_chats, {
			name = data.name,
			interaction = "chat",
			description = data.description,
			bufnr = data.chat.bufnr,
			callback = function()
				codecompanion.close_last_chat()
				data.chat.ui:open()
			end,
		})
	end

	return open_chats
end

local function setup()
	local codecompanion = require("codecompanion")
	codecompanion.setup({
		display = {
			chat = {
				window = {
					position = "right",
				},
			},
			diff = {
				enabled = false,
			},
			action_palette = {
				provider = "default",
				opts = {
					show_preset_actions = false, -- Show the preset actions in the action palette?
					show_preset_prompts = false, -- Show the preset prompts in the action palette?
					show_preset_rules = false, -- Show the preset rules in the action palette?
				},
			},
		},
		-- Using array-table instead of named-table so that order is more predictable. However, it seems that name gets
		-- used only if it's a function
		prompt_library = {
			{
				name = function()
					return "New chat"
				end,
				interaction = "chat",
				description = "Create a new chat buffer to converse with an LLM",
				prompts = {
					n = function()
						return codecompanion.chat()
					end,
					v = {
						{ role = "user" },
					},
				},
			},
			{
				name = function()
					return "Rename chat title"
				end,
				interaction = "chat",
				description = "Rename the current chat title",
				condition = function(context)
					return context.filetype == "codecompanion"
				end,
				prompts = {
					n = function()
						vim.ui.input({ prompt = "Rename chat title:" }, function(x)
							codecompanion.buf_get_chat(vim.api.nvim_get_current_buf()):set_title(x)
						end)
					end,
				},
			},
			{
				name = function()
					return "Open chats ..."
				end,
				interaction = " ",
				description = "Your currently open chats",
				opts = { stop_context_insertion = true },
				condition = function()
					return #codecompanion.buf_get_chat() > 0
				end,
				picker = {
					prompt = "Select a chat",
					columns = { "bufnr", "description" },
					items = function()
						return get_open_chats()
					end,
				},
			},
			{
				name = function()
					return "Execution Buddy"
				end,
				interaction = "chat",
				description = "Help user to get something done",
				opts = {
					index = 99,
					rules = "default",
					intro_message = "This chat is now preset to help you complete task.",
				},
				prompts = {
					{
						role = "system",
						content = [[ Use deep logical thinking to aid the user on the task he is on. Investigate the current working directory or go online to learn more about the situation. Be short in your reply and keep using this mode until user dismiss the agent

## Guidelines

- Use @{get_changed_files} to understand what is changed
- The next step is the first task on the list that is not checked off
- If ./wip.md exists, check off the task once you completed it
- If you are ensure of what is required for the next step, you can confirm with the user first
]],
					},
					{
						role = "user",
						content = "@{full_stack_dev} @{web} Execute the next step in ./wip.md",
					},
				},
			},
		},
		interactions = {
			background = {
				chat = {
					callbacks = {
						["on_ready"] = {
							actions = {
								"interactions.background.builtin.chat_make_title",
							},
							-- Enable "on_ready" callback which contains the title generation action
							enabled = true,
						},
					},
					opts = {
						-- Enable background interactions generally
						enabled = true,
					},
				},
			},
			chat = {
				adapter = {
					name = "copilot",
					model = "gpt-4.1",
				},
				keymaps = {
					next_chat = { modes = { n = "<c-n>" } },
					previous_chat = { modes = { n = "<c-p>" } },
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
							-- TODO Sending a PR for error where buffer is not saved when diff is off
							-- require("codecompanion.interactions.chat.tools.builtin.insert_edit_into_file"),
							require("mod.codecompanion.insert_edit_into_file"),
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
	utils.keymap({ "n", "i", "v" }, "<c-space>", function()
		codecompanion.actions({
			-- Remove "interaction" column because I am using action to put some other non-chat related function and
			-- they still need to be placed as "chat" for interaction
			provider = {
				name = "default",
				opts = {
					columns = { "name", "description" },
				},
			},
		})
	end)

	local group_name = "lCodeCompanion"
	vim.api.nvim_create_augroup(group_name, { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "codecompanion",
		callback = function(opt)
			utils.buf_keymap(opt.buf, "n", "q", function()
				codecompanion.toggle()
			end)
			utils.buf_keymap(opt.buf, "n", "<cr>", function()
				local chats = get_open_chats()
				require("codecompanion.providers.actions.default"):picker(chats, {
					columns = { "bufnr", "description" },
				})
			end)
		end,
		group = group_name,
	})
end

return {
	-- https://github.com/olimorris/codecompanion.nvim
	-- https://github.com/nvim-lua/plenary.nvim
	-- https://github.com/ravitemer/mcphub.nvim
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"ravitemer/mcphub.nvim",
	},
	version = "*",
	config = setup,
}
