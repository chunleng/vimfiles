local M = {}

---@param tool_callback CodeCompanion.Tools.Tool
---@param precheck function
function M.wrap(tool_callback, precheck)
	table.insert(tool_callback.cmds, 1, precheck)
	return tool_callback
end

---@param path string
function M.validate_in_cwd(path)
	local absolute_path = vim.fn.fnamemodify(path, ":p")
	local cwd = vim.fn.getcwd() .. "/"
	if absolute_path:sub(1, #cwd) ~= cwd then
		return {
			status = "error",
			data = "Reading outside of current working directory is not allowed",
		}
	end

	return {
		status = "success",
		data = "Precheck passed",
	}
end

return M
