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

local function find_global_override_files()
	local results = {}
	local current_path = vim.fn.getcwd()

	while current_path ~= "/" do
		local override_file = current_path .. "/.vim/global_override.lua"
		if vim.fn.filereadable(override_file) == 1 then
			table.insert(results, override_file)
		end
		current_path = vim.fn.fnamemodify(current_path, ":h")
	end

	-- Return result from the higher path, so that lower path can resolve with variable from a higher path
	return vim.iter(results):rev():totable()
end

local function resolve_override_file(override_file)
	local success, lua_content_or_error = pcall(dofile, override_file)
	if success then
		if lua_content_or_error and check_approval(override_file) then
			return lua_content_or_error
		end
	else
		vim.notify(lua_content_or_error, vim.log.levels.ERROR)
	end
	return nil
end

local override_files = find_global_override_files()

for _, override_file in ipairs(override_files) do
	local override = resolve_override_file(override_file)
	if override then
		-- We
		package.loaded["mod.global_constants"] = vim.tbl_deep_extend("force", require("mod.global_constants"), override)
	end
end

return {}
