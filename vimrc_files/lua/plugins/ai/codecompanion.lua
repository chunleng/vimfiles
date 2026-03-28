local codecompanion_constants = require("mod.global_constants").codecompanion
local utils = require("common-utils")

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
			require("mod.ai.codecompanion.prompt_library.send_text_to_chat"),
			require("mod.ai.codecompanion.prompt_library.new_chat"),
			require("mod.ai.codecompanion.prompt_library.new_chat_with_buffer"),
			require("mod.ai.codecompanion.prompt_library.open_history"),
			require("mod.ai.codecompanion.prompt_library.rename_chat"),
			require("mod.ai.codecompanion.prompt_library.feature_writer"),
			require("mod.ai.codecompanion.prompt_library.coder").coder,
			require("mod.ai.codecompanion.prompt_library.coder").coder_agent,
			(#codecompanion_constants.issue.tools + #codecompanion_constants.issue.groups > 0) and require(
				"mod.ai.codecompanion.prompt_library.issue"
			) or nil,
			(#codecompanion_constants.git.tools + #codecompanion_constants.git.groups > 0) and require(
				"mod.ai.codecompanion.prompt_library.pull_request"
			) or nil,
			require("mod.ai.codecompanion.prompt_library.diagnostic"),
		},
		interactions = {
			background = {
				adapter = codecompanion_constants.models.cheap.adapter,
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
				adapter = codecompanion_constants.models.general,
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
					change_adapter = { modes = { n = "gA" } },
					change_preffered_adapter = {
						modes = { n = "ga" },
						index = 15,
						callback = function(chat)
							local models = codecompanion_constants.models
							vim.ui.select(vim.tbl_keys(models), {

								prompt = "Select a model",
								format_item = function(item)
									local model = models[item]
									return string.format("%s: %s|%s", item, model.adapter, model.model)
								end,
							}, function(selected)
								local model = models[selected]
								if model then
									chat:change_adapter(model.adapter)
									chat:change_model({ model = model.model })
								end
							end)
						end,
						description = "[Adapter] Change to favorite adapter and model",
					},
				},
				slash_commands = {
					terminal = { enabled = false }, -- Disable because it's not verbose
					now = { enabled = false }, -- Disable because there're better ways
					help = { enabled = false }, -- Too niche to vim
					file_by_path = {
						path = "mod.ai.codecompanion.slash_commands.file_by_path",
					},
				},
				tools = {
					memory = { enabled = false },
					get_changed_files = { enabled = false },
					time_now = {
						path = "plugins.ai.codecompanion.tools.time_now",
					},
					wait = {
						path = "plugins.ai.codecompanion.tools.wait",
					},
					speak = { path = "plugins.ai.codecompanion.tools.speak" },
					file_search = {
						path = "plugins.ai.codecompanion.tools.fd_search",
					},
					grep_search = { opts = { require_approval_before = false } },
					read_file = {
						path = "plugins.ai.codecompanion.tools.read_file",
						opts = {
							require_approval_before = false,
						},
					},
					insert_edit_into_file = {
						path = "plugins.ai.codecompanion.tools.insert_edit_into_file",
						opts = {
							require_confirmation_after = false,
						},
					},
					create_file = {
						path = "plugins.ai.codecompanion.tools.create_file",
						opts = {
							require_approval_before = false,
						},
					},
					delete_file = {
						path = "plugins.ai.codecompanion.tools.delete_file",
						opts = {
							require_approval_before = false,
						},
					},
					run_command = {
						path = "plugins.ai.codecompanion.tools.run_command",
					},
					git_current_branch = {
						path = "plugins.ai.codecompanion.tools.git_current_branch",
					},
					git_diff = {
						path = "plugins.ai.codecompanion.tools.git_diff",
					},
					subagent__generic = {
						path = "plugins.ai.codecompanion.tools.subagent__generic",
						visible = false,
					},
					reply_agent = {
						path = "plugins.ai.codecompanion.tools.reply_agent",
						visible = false,
					},
					groups = {
						agent = {
							system_prompt = function()
								return [[<guidelines>
- Achieve user's objective without minimal user intervention. e.g.
  - If you are faced with choices, go with what you think is the best for the current situation
  - If the objective is not met, instead of stopping, thinking about what to do next and repeat until user's condition is met
</guidelines>]]
							end,
							tools = {
								"insert_edit_into_file",
								"delete_file",
								"create_file",
								"get_diagnostics",
								"run_project_command",
								"run_command",
							},

							opts = {
								ignore_system_prompt = false,
								ignore_tool_system_prompt = false,
							},
						},
						subagent = {
							description = "Tools to spawn a LLM agent to help perform tasks",
							prompt = "I'm giving you access to ${tools} that helps you spawn LLM agent to help you offload task to",
							system_prompt = [[When given subagent tool, you are advised to offload operations that are likely to give you too much information or when there're specialized subagent tools for it
<examples>
<webSearchExample>
**SCENARIO**: Search for solution to printing log in rust
**WHY OFFLOAD**: Browsing and searching the web for answer requires going through data before reaching to a conclusion
**HOW TO OFFLOAD**: I want to know how to print logs in rust, please search the web for alternatives and decide on which is best for easy to setup. Return me a short summary on what to use and how to use it.
**HOW NOT TO OFFLOAD**: I want to know how to print logs in rust, search the web for how
**WHY NOT**: This does not make it easier than searching by yourself
</webSearchExample>
<webScrapingExample>
**SCENARIO**: Finding out which GitHub repository has most stars
**WHY OFFLOAD**: Going to pages to get answer can be expensive, therefore it's much easier to offload it
**HOW TO OFFLOAD**: (Open one subagent per website) Open https://github.com/abc/xyz and tell me the how many people starred the repository. Return me just the integer of star count
**HOW NOT TO OFFLOAD**: Tell me how many people starred the following repositories: https://github.com/abc/xyz, https://github.com/abc/uvw, ...
**WHY NOT**: Always parallelize when the task can be parallelized.
</webScrapingExample>
<searchCodeExample>
**SCENARIO**: Find out where the codes are being used.
**WHY OFFLOAD**: Keyword search has a high chance to load unnecessary context that is going to distract you from your main task
**HOW TO OFFLOAD**: Search for where `foo` function of the `Bar` struct and return me `<path>:<line_no>` of both the definition and the reference code
**HOW NOT TO OFFLOAD**: Search for `foo` function
**WHY NOT**: Always take the chance to filter off unnecessary result. Let subagent know the format of return so that you can understand easily
</searchCodeExample>
<fileSearchExample>
**SCENARIO**: Locating a file by name
**WHY OFFLOAD**: Multiple files can be found and we don't want to spend the context to check them
**HOW TO OFFLOAD**: Find `README.md` that is used to guide user on how to setup the workspace for this repository. Return me the ONE file that fit the criteria most.
**HOW NOT TO OFFLOAD**: Find where `README.md` is
**WHY NOT**: If you don't state the purpose, the subagent might give you inaccurate result when multiple files is returned
</fileSearchExample>
<summaryExample>
**SCENARIO**: Summarize files in the folder
**WHY OFFLOAD**: Divide and conquer makes task faster
**HOW TO OFFLOAD**: Offload to several agents, each agent summarizes a few files each. The main agent reads the summary and produce the final summary
**HOW NOT TO OFFLOAD**: Offload all files to a single agent
**WHY NOT**: The main agent is not useful in the entire process and simply wait for answer
</summaryExample>
</examples>
<guidelines>
- Instead of giving multiple tasks to one subagent, give one task to each subagent to perform
- If you can, parallelize your call to subagent
</guidelines>]],
							tools = { "subagent__generic" },
						},
						core_utils = {
							description = "Utility tools that does not generally cause trouble when used",
							prompt = "I'm giving you access to ${tools} that helps you communicate better with the user",
							tools = { "ask_questions", "time_now", "wait" },
						},
						git = {
							description = "Tools to interact with git",
							prompt = "I'm giving you access to ${tools} that can help you run git-related operations",
							tools = { "git_current_branch", "git_diff" },
						},
						read_only = {
							description = "Tools related to reading files",
							prompt = "I'm giving you access to ${tools} to help you perform read-only file operations",
							tools = { "file_search", "grep_search", "read_file" },
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
								"grep_search",
								"read_file",
							},
						},
						math = {
							tools = {
								"calculator__calculate",
							},
						},
					},
					opts = {
						default_tools = { "read_only", "math", "core_utils", "web" },
						system_prompt = {
							enabled = false,
						},
					},
				},
				opts = {
					system_prompt = function()
						return [[<global_instruction>
<guidelines>
<tools>
	All tools available are free to use. Please do not ask permission when using them. Always seek the help of relevant tools before replying
	e.g.
		When you perform calculation, always use the @{calculator__calculate} tool
		When you have question to the user, ask the question via @{ask_questions} tool
		When answer is likely outdated, check the answer validity via @{web_search} tool
</tools>
<chatFormat>strictly markdown, if heading is used, please refrain using `#` and `##` and start from heading 3</chatFormat>
</global_instruction>]]
					end,
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
					title_generation_opts = codecompanion_constants.models.cheap,
					auto_save = true,
					expiration_days = 7,
					picker = "fzf-lua",
					continue_last_chat = false,
					dir_to_save = vim.fn.stdpath("data") .. "/" .. vim.fn.getcwd(),
				},
			},
			spinner = {
				opts = {
					style = "lualine",
					-- Because of the way the lualine formats it's display, I have configured to use spacing so that it
					-- can reliably display the icon
					default_icon = "",
					content = {
						thinking = { icon = "", message = "Thinking...", spacing = "   " },
						receiving = { icon = "", message = "Receiving...", spacing = "   " },
						done = { icon = "", message = "Done!", spacing = "   " },
						cleared = { icon = "", message = "Chat cleared", spacing = "   " },
						tools_started = { icon = "", message = "Running tools...", spacing = "   " },
						tools_finished = { icon = "", message = "Processing tool output...", spacing = "   " },
					},
				},
			},
		},
		adapters = {
			http = {
				ollama_online = function()
					return require("codecompanion.adapters").extend("ollama", {
						env = {
							url = "https://ollama.com",
						},
						headers = {
							["Content-Type"] = "application/json",
							Authorization = "Bearer " .. vim.fn.getenv("OLLAMA_API_KEY"),
						},
						handlers = {
							chat_output = function(self, data, tools)
								local original_func_output =
									require("codecompanion.adapters.http.ollama").handlers.chat_output(
										self,
										data,
										tools
									)

								if original_func_output then
									original_func_output.output.reasoning = nil
								end
								return original_func_output
							end,
						},
					})
				end,
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
			["bestpractice/git/conventional_commits"] = {
				description = "Best practice for Git's conventional commits",
				files = {
					"~/Dropbox/Notes/zettelkasten/permanent/conventional_commits.md",
				},
			},
			opts = {
				chat = {
					autoload = false, -- No default groups
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
	-- https://github.com/lalitmee/codecompanion-spinners.nvim
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- Fix codecompanion 19.0 upgrade, to rollback when ravitemer/mcphub.nvim is updated
		"bahaaza/mcphub.nvim",
		"ravitemer/codecompanion-history.nvim",
		"lalitmee/codecompanion-spinners.nvim",
	},
	version = "*",
	config = setup,
}
