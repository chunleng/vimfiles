local M = {}

--- @param rust_config table<string, Custom.Lsp.Rust.Config|false>
function M.override_check_parameters(rust_config)
	return function(init_params, config)
		local cwd = vim.fn.getcwd()

		-- Out of the project files cargo will be left as is
		if init_params.rootPath:sub(1, #cwd) ~= cwd then
			config.settings["rust-analyzer"].cargo = {}
			return
		end

		-- Conditionally, we can also set different features/target for different workspace member
		local path_from_root = init_params.rootPath:sub(#cwd + 2)
		local override = rust_config[path_from_root] or rust_config["*"]
		if override then
			config.settings["rust-analyzer"].cargo =
				vim.tbl_extend("force", config.settings["rust-analyzer"].cargo or {}, override)
		end
	end
end

return M
