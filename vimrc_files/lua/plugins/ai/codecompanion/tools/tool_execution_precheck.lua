local M = {}

local codecompanion_constant = require("mod.global_constants").codecompanion

---@param tool_callback CodeCompanion.Tools.Tool
---@param precheck function
function M.wrap(tool_callback, precheck)
	table.insert(tool_callback.cmds, 1, precheck)
	return tool_callback
end

---@param path string
---@param op "r"|"w"
function M.validate_safe_filepath(path, op)
	local absolute_path = vim.fn.fnamemodify(path, ":p")
	local relative_path = vim.fn.fnamemodify(path, ":.")
	local filename = vim.fn.fnamemodify(path, ":t")
	local cwd = vim.fn.getcwd() .. "/"
	local success_message = {
		status = "success",
		data = "Precheck passed",
	}

	if relative_path:sub(1, 4) == ".vim" and relative_path ~= ".vim/wip.md" then
		return {
			status = "error",
			data = ".vim cannot be access/modified as it may consist of secret settings",
		}
	end

	if vim.tbl_contains({ ".env", ".envrc" }, filename) then
		return {
			status = "error",
			data = "secret files access/modification are not allowed",
		}
	end

	if op == "r" then
		if
			vim.tbl_contains(codecompanion_constant.whitelist.additional_readable_directory, function(x)
				local absolute_x = vim.fn.fnamemodify(x, ":p")
				return vim.startswith(absolute_path, absolute_x)
			end, { predicate = true })
		then
			return success_message
		end
	end

	if absolute_path:sub(1, #cwd) ~= cwd then
		return {
			status = "error",
			data = "File operation outside of current working directory is not allowed",
		}
	end

	return success_message
end

return M
