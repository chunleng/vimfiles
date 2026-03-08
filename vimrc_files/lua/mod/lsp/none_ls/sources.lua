local M = {}
local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

---@param config Custom.Lsp.Rust.Config
function M.cargo_check(config)
	local cwd = vim.fn.fnamemodify(config.cwd, ":p")
	local lsp_name = "cargo_check"

	local args = { "check", "--message-format=json", "--quiet", "--keep-going", "--tests" }
	if config.package then
		-- lsp_name = lsp_name .. ":" .. config.package
		args = vim.list_extend(args, { "-p", config.package })
	end
	if not config.workspace_root then
		local result = vim.fn.system("cargo metadata --no-deps --format-version 1 2>/dev/null")
		local metadata = vim.fn.json_decode(result)
		config.workspace_root = metadata.workspace_root
	end
	if config.example then
		lsp_name = lsp_name .. ":" .. config.example
		args = vim.list_extend(args, { "--example", config.example })
	end
	if config.target then
		args = vim.list_extend(args, { "--target", config.target })
	end
	if config.features and #config.features > 0 then
		args = vim.list_extend(args, { "--features", table.concat(config.features, ",") })
	end
	if config.noDefaultFeatures then
		args = vim.list_extend(args, { "--no-default-features" })
	end

	return helpers.make_builtin({
		name = lsp_name,
		method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
		filetypes = { "rust" },
		generator_opts = {
			command = "cargo",
			args = args,
			to_stdin = false,
			from_stderr = false,
			ignore_stderr = true,
			multiple_files = true,
			format = "line",
			cwd = function()
				return cwd
			end,
			runtime_condition = function(params)
				return vim.startswith(params.bufname, cwd)
			end,
			check_exit_code = function(code)
				return code <= 1
			end,
			on_output = function(line, params)
				local ok, decoded = pcall(vim.json.decode, line)
				if not ok or not decoded then
					vim.lsp.log.error(lsp_name, "Failed to parse JSON line:" .. line)
					return nil
				end

				if decoded.reason ~= "compiler-message" then
					return nil
				end

				local msg = decoded.message
				if not msg or not msg.spans then
					return nil
				end

				local severity_map = {
					error = vim.diagnostic.severity.ERROR,
					warning = vim.diagnostic.severity.WARN,
					note = vim.diagnostic.severity.HINT,
					help = vim.diagnostic.severity.INFO,
				}

				for _, span in ipairs(msg.spans) do
					if span.is_primary then
						return {
							filename = config.workspace_root .. "/" .. span.file_name,
							row = span.line_start,
							col = span.column_start,
							end_row = span.line_end,
							end_col = span.column_end,
							message = msg.message,
							severity = severity_map[msg.level] or vim.diagnostic.severity.ERROR,
							source = lsp_name,
						}
					end
				end

				return nil
			end,
			env = config.extraEnv,
		},
		factory = helpers.generator_factory,
	})
end

--- @param configs table<string, Custom.Lsp.Rust.Config>
function M.cargo_checks(configs)
	configs = configs or {}
	local result = vim.fn.system("cargo metadata --no-deps --format-version 1 2>/dev/null")

	if vim.v.shell_error ~= 0 then
		return {}
	end

	local metadata = vim.fn.json_decode(result)
	local checks = {}
	local cwd = vim.fn.getcwd()

	for _, pkg in ipairs(metadata.packages) do
		local manifest_dir = vim.fn.fnamemodify(pkg.manifest_path:sub(#(cwd .. "/") + 1), ":h")
		local has_code_target = false

		for _, target in ipairs(pkg.targets) do
			if target.kind then
				if vim.tbl_contains(target.kind, "example") then
					table.insert(
						checks,
						M.cargo_check(
							vim.tbl_extend(
								"force",
								{ cwd = manifest_dir, package = pkg.name, example = target.name },
								configs[manifest_dir .. "//" .. target.name] or configs["*"] or {}
							)
						)
					)
				else
					has_code_target = true
				end
			end
		end
		if has_code_target then
			table.insert(
				checks,
				M.cargo_check(
					vim.tbl_extend(
						"force",
						{ cwd = manifest_dir, package = pkg.name },
						configs[manifest_dir] or configs["*"] or {}
					)
				)
			)
		end
	end
	return checks
end

return M
