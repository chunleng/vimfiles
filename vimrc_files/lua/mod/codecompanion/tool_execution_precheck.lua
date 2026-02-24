local M = {}

---@param tool_callback CodeCompanion.Tools.Tool
---@param precheck function
function M.wrap(tool_callback, precheck)
	table.insert(tool_callback.cmds, 1, precheck)
	return tool_callback
end

---@param path string
function M.validate_safe_filepath(path)
	local absolute_path = vim.fn.fnamemodify(path, ":p")
	local relative_path = vim.fn.fnamemodify(path, ":.")
	local filename = vim.fn.fnamemodify(path, ":t")
	local cwd = vim.fn.getcwd() .. "/"

	if absolute_path:sub(1, #cwd) ~= cwd then
		return {
			status = "error",
			data = "File operation outside of current working directory is not allowed",
		}
	end

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

	return {
		status = "success",
		data = "Precheck passed",
	}
end

return M
