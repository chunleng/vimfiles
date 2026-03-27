local codecompanion_constants = require("mod.global_constants").codecompanion

local codecompanion = require("codecompanion")
local codecompanion_constants = require("mod.global_constants").codecompanion

return {
	name = "subagent__generic",
	cmds = {
		---Execute the search commands
		-----@param _ CodeCompanion.Tool.FileSearch
		---@param args table The arguments from the LLM's tool call
		---@param opts table The output from the previous function call
		function(_, args, opts)
			local generated_session_id = "reply_agent_" .. vim.api.nvim_get_current_buf() .. "_" .. vim.loop.hrtime()

			local timer = vim.loop.new_timer()
			local chat = nil
			local close_chat = function()
				if chat then
					vim.schedule(function()
						vim.defer_fn(function()
							chat:close()
						end, 10000)
					end)
				end
			end
			local autocmd_id = vim.api.nvim_create_autocmd("User", {
				pattern = generated_session_id,
				once = true, -- automatically removed after first trigger
				callback = function(cb)
					-- Cancel the timer when autocmd triggers successfully
					if timer then
						timer:stop()
						timer:close()
					end
					close_chat()
					opts.output_cb({
						status = "success",
						data = cb.data,
					})
				end,
			})

			timer:start(5 * 60 * 1000, 0, function()
				vim.schedule(function()
					-- Remove the autocmd if it hasn't triggered yet
					pcall(vim.api.nvim_del_autocmd, autocmd_id)

					close_chat()

					opts.output_cb({
						status = "error",
						data = "Sub agent failed to reply after 5 minutes",
					})
				end)
				timer:stop()
				timer:close()
			end)

			chat = codecompanion.chat({
				auto_submit = false,
				hidden = true,
				params = codecompanion_constants.models.cheap,
				messages = {
					{
						role = "system",
						content = "You are called to perform a task for another LLM. Keep your response brief and do not add any commentary such as summarizing your thoughts and action. Once you are ready to answer, use the @{reply_agent} and reply using the session_id `"
							.. generated_session_id
							.. "` with the answer",
					},
					-- TODO find out how to use chat.tool_registry:add_single_tool. At the point of writing, having
					-- another block to modify the chat caused errors
					{ role = "user", content = args.prompt },
				},
			})
			if chat then
				vim.schedule(function()
					chat.tool_registry:add_single_tool("reply_agent", {})
					chat:submit({})
				end)
			end
		end,
	},
	schema = {
		type = "function",
		["function"] = {
			name = "subagent__generic",
			description = [[Spawn a new generic agent to perform a task for you. This agent is loaded with web and file listing/reading capabilities
When assigning task for the sub agent, be clear about the requirement and what you expect as the response]],
			parameters = {
				type = "object",
				properties = {
					prompt = {
						type = "string",
						description = [[The details of the command to the sub agent]],
					},
				},
				required = {
					"prompt",
				},
			},
		},
	},
	output = {
		error = function(self, stderr, meta)
			local chat = meta.tools.chat
			local errors = table.concat(stderr, "\n")
			chat:add_tool_output(self, errors)
		end,

		---@param self CodeCompanion.Tool.FileSearch
		---@param stdout table The output from the command
		---@param meta { tools: CodeCompanion.Tools, cmd: table }
		success = function(self, stdout, meta)
			local chat = meta.tools.chat
			local data = stdout[1]

			chat:add_tool_output(self, data, "Subagents responded")
		end,
	},
}
