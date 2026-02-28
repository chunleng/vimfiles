local function setup_lsp_mappings()
	local utils = require("common-utils")
	utils.keymap("n", "<leader>cf", function()
		local first = true
		vim.lsp.buf.code_action({
			context = { diagnostics = {}, only = { "quickfix" } },
			filter = function()
				local f = first
				first = false
				return f
			end,
			apply = true,
		})
	end)
	utils.keymap("n", "<leader>ca", function()
		vim.lsp.buf.code_action({ apply = true })
	end)
	utils.keymap("n", "<leader>cr", function()
		vim.lsp.buf.rename()
	end)
	utils.keymap("n", "<leader>c=", function()
		vim.lsp.buf.format({ async = true })
	end)
	utils.keymap("n", "<leader>cu", "<cmd>FzfLua lsp_references<cr>")
	utils.keymap("n", "<leader>cd", "<cmd>FzfLua lsp_document_diagnostics<cr>")
	utils.keymap("n", "<leader>c?", "<cmd>FzfLua lsp_workspace_diagnostics<cr>")
	utils.keymap("n", { "[d", "[<c-d>" }, function()
		local virtual_lines = vim.diagnostic.config()["virtual_lines"]
		vim.diagnostic.jump({
			count = -1,
			float = not virtual_lines,
			severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN, vim.diagnostic.severity.INFO },
		})
	end)
	utils.keymap("n", { "]d", "]<c-d>" }, function()
		local virtual_lines = vim.diagnostic.config()["virtual_lines"]
		vim.diagnostic.jump({
			count = 1,
			float = not virtual_lines,
			severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN, vim.diagnostic.severity.INFO },
		})
	end)
	utils.keymap("i", { "<c-h>" }, function()
		vim.lsp.buf.signature_help()
	end)
end

local function defer_lsp_start(clients_to_restart, times_to_retry)
	vim.defer_fn(function()
		if #vim.lsp.get_clients() == 0 then
			for _, client in ipairs(clients_to_restart) do
				-- - if there an lsp.config, just re-enable as user might have updated the config and triggered the
				--   restart
				-- - user_lsp_config can be nil if it's set through means like null-ls
				local user_lsp_config = vim.lsp.config[client.config.name]
				if user_lsp_config then
					vim.lsp.enable(client.config.name)
				else
					local client_id = vim.lsp.start(client.config)
					if client_id then
						for _, bufnr in ipairs(client.attached_buffers) do
							vim.lsp.buf_attach_client(bufnr, client_id)
						end
					else
						vim.notify(
							"Failed to restart LSP: " .. client.config.name .. "@" .. client.config.root_dir,
							vim.log.levels.ERROR
						)
					end
				end
			end
		else
			times_to_retry = times_to_retry - 1
			if times_to_retry == 0 then
				return
			else
				defer_lsp_start(clients_to_restart, times_to_retry)
			end
		end
	end, 300)
end

---@param _args vim.api.keyset.create_user_command.command_args
local function lsp_restart(_args)
	local clients = vim.lsp.get_clients({})

	if vim.tbl_isempty(clients) then
		vim.notify("No active LSP clients found", vim.log.levels.WARN)
		return
	end

	local clients_to_restart = {}
	for _, client in ipairs(clients) do
		table.insert(clients_to_restart, {
			config = client.config,
			attached_buffers = vim.tbl_keys(client.attached_buffers),
		})
		client:stop()
	end

	defer_lsp_start(clients_to_restart, 20)
end

local function setup()
	setup_lsp_mappings()

	-- Change rust_analyzer's default showMessage because it can be quite noisy
	vim.lsp.handlers["window/showMessage"] = function(_, result, ctx)
		local client = vim.lsp.get_client_by_id(ctx.client_id)
		if client and client.name == "rust_analyzer" then
			return
		end
		-- default behavior for others
		vim.notify(result.message)
	end
	vim.api.nvim_create_user_command("LspRestart", lsp_restart, {})
end

return {
	{
		dir = vim.fn.stdpath("config") .. "/lua/plugins/lsp",
		dependencies = {
			{ import = "plugins.lsp.lazydev" },
			{ import = "plugins.lsp.none_ls" },
			{ import = "plugins.lsp.schemastore" },
			{ import = "plugins.lsp.ltex_extra" },
			{ import = "plugins.lsp.mason" },
		},
		config = setup,
	},
}
