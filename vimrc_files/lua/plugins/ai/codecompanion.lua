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
		prompt_library = {
			require("mod.ai.codecompanion.prompt_library.new_chat"),
			require("mod.ai.codecompanion.prompt_library.open_history"),
			require("mod.ai.codecompanion.prompt_library.rename_chat"),
			require("mod.ai.codecompanion.prompt_library.execution_buddy"),
			require("mod.ai.codecompanion.prompt_library.research"),
			require("mod.ai.codecompanion.prompt_library.question"),
			require("mod.ai.codecompanion.prompt_library.diagnostic"),
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
					clear = false,
					codeblock = false,
					buffer_sync_all = false,
					buffer_sync_diff = false,
					fold_code = false,
					system_prompt = false,
					rules = false,
					clear_approvals = false,
					yolo_mode = false,
					super_diff = false,
					yank_code = { modes = { n = "yic" } },
					goto_file_under_cursor = { modes = { n = "gf" } },
					close = { modes = { n = "<c-q>" } },
					next_chat = { modes = { n = "<c-n>" } },
					previous_chat = { modes = { n = "<c-p>" } },
					send = { modes = { n = "<c-cr>", i = "<c-cr>" } },
					stop = { modes = { n = "<c-c>", i = "<c-c>" } },
				},
				slash_commands = {
					terminal = { enabled = false }, -- Disable because it's not verbose
					now = { enabled = false }, -- Disable because there're better ways
					help = { enabled = false }, -- Too niche to vim
					file_by_path = {
						callback = "mod.ai.codecompanion.slash_commands.file_by_path",
					},
				},
				tools = {
					memory = { enabled = false },
					file_search = {
						callback = require("mod.codecompanion.fd_search"),
					},
					grep_search = { opts = { require_approval_before = false } },
					read_file = {
						callback = tool_execution_precheck.wrap(
							require("codecompanion.interactions.chat.tools.builtin.read_file"),
							function(_, args, _)
								return tool_execution_precheck.validate_safe_filepath(args.filepath)
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
								return tool_execution_precheck.validate_safe_filepath(args.filepath)
							end
						),
						opts = {
							require_confirmation_after = false,
						},
					},
					create_file = {
						callback = tool_execution_precheck.wrap(
							require("codecompanion.interactions.chat.tools.builtin.create_file"),
							function(_, args, _)
								return tool_execution_precheck.validate_safe_filepath(args.filepath)
							end
						),
						opts = {
							require_approval_before = false,
						},
					},
					delete_file = {
						callback = tool_execution_precheck.wrap(
							require("codecompanion.interactions.chat.tools.builtin.delete_file"),
							function(_, args, _)
								return tool_execution_precheck.validate_safe_filepath(args.filepath)
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
								"create_file",
								"file_search",
								"get_changed_files",
								"grep_search",
								"read_file",
							},
						},
					},
					opts = {
						default_tools = { "read_only", "sequential_thinking" },
						system_prompt = {
							enabled = false,
						},
					},
				},
				opts = {
					system_prompt = [[<global_instruction>This setting sets a tone for all the conversation in this chat
<guidelines>
<coding>
- If you are given the way to test or format the code, use it to check before you complete the task
- Don't add comments unless they explain why, not what
- If tools are given, you are free to use it without asking for permission
- When encountering an issue, use @{sequential_thinking} to log down the problem and debug
- @{sequential_thinking} is a hard tool to use, please think deeper on how to format it before calling
- Before using @{cmd_runner}, always try using other tools first, especially @{file_search} for listing file and @{read_file} for checking file content
</coding>
<outputFormat>
strictly markdown, if heading is used, please use start from heading 3
</outputFormat>
</global_instruction>]],
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
			history = {
				opts = {
					auto_generate_title = true,
					auto_save = true,
					expiration_days = 7,
					picker = "fzf-lua",
					continue_last_chat = false,
					dir_to_save = vim.fn.stdpath("data") .. "/" .. vim.fn.getcwd(),
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
					"AGENTS.md",
					".vim/AGENTS.md",
				},
			},
			["bestpractice/terragrunt"] = {
				description = "Best practice for terragrunt project",
				files = {
					"~/Dropbox/Notes/zettelkasten/permanent/terragrunt-common-practice.md",
				},
			},
			opts = {
				chat = {
					autoload = "default", -- The rule groups to load
					enabled = true,
				},
			},
		},
		opts = {
			log_level = "ERROR",
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
	-- https://github.com/ravitemer/codecompanion-history.nvim
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"ravitemer/mcphub.nvim",
		"ravitemer/codecompanion-history.nvim",
	},
	version = "*",
	config = setup,
}
