local function compute_hash(content)
	return vim.fn.sha256(vim.fn.json_encode(content))
end

local function check_approval(path)
	local approval_file = vim.fn.stdpath("data") .. "/global_constants" .. path
	local content_hash = compute_hash(vim.fn.readfile(path))

	if vim.fn.filereadable(approval_file) == 1 then
		local file_content = vim.fn.readfile(approval_file)[1]
		local parts = vim.split(file_content, " ")
		local stored_hash = parts[1]
		local approved = parts[2] == "true"

		if stored_hash == content_hash then
			return approved
		end
	end

	local choice = vim.fn.confirm("Load global override from " .. path .. "?", "&Yes\n&No")

	local approved = choice == 1

	vim.fn.mkdir(vim.fn.fnamemodify(approval_file, ":h"), "p")
	vim.fn.writefile({ content_hash .. " " .. tostring(approved) }, approval_file)

	return approved
end

local function find_global_overrides()
	local results = {}
	local current_path = vim.fn.getcwd()

	while current_path ~= "/" do
		local override_file = current_path .. "/.vim/global_override.lua"
		if vim.fn.filereadable(override_file) == 1 then
			local success, lua_content_or_error = pcall(dofile, override_file)
			if success then
				if lua_content_or_error and check_approval(override_file) then
					table.insert(results, lua_content_or_error)
				end
			else
				vim.notify(lua_content_or_error, vim.log.levels.ERROR)
			end
		end
		current_path = vim.fn.fnamemodify(current_path, ":h")
	end

	return results
end

local new_global_constants = {}
local overrides = find_global_overrides()
for _, override in ipairs(overrides) do
	new_global_constants = vim.tbl_deep_extend("keep", new_global_constants, override)
end

package.loaded["mod.global_constants"] =
	vim.tbl_deep_extend("keep", new_global_constants, require("mod.global_constants"))

return {}
