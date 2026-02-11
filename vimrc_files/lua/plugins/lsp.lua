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
		vim.diagnostic.jump({ count = -1, float = true })
	end)
	utils.keymap("n", { "]d", "]<c-d>" }, function()
		vim.diagnostic.jump({ count = 1, float = true })
	end)
	utils.keymap("i", { "<c-h>" }, function()
		vim.lsp.buf.signature_help()
	end)
end

local function setup()
	setup_lsp_mappings()
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
