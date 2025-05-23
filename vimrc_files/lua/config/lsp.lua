local M = {}

local utils = require("common-utils")

local function setup_lsp_mappings()
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

local function setup_dap()
	local dap_setup = require("mason-nvim-dap")
	local dap = require("dap")
	local dapui = require("dapui")

	local theme = require("common-theme")
	theme.set_hl("DapBreakpointText", { fg = 14 })
	theme.set_hl("DapStoppedText", { fg = 10 })
	vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpointText" })
	vim.fn.sign_define("DapStopped", {
		text = "",
		texthl = "DapStoppedText",
		linehl = "CursorLine",
	})

	utils.keymap("n", "<leader>db", "<cmd>DapToggleBreakpoint<cr>")
	utils.keymap("n", "<leader>dc", "<cmd>DapContinue<cr>")
	utils.keymap("n", "<leader>dd", '<cmd>lua require("dap").run_last()<cr>')
	utils.keymap("n", { "<leader>dl", "<right>" }, "<cmd>DapStepOver<cr>")
	utils.keymap("n", { "<leader>dj", "<down>" }, "<cmd>DapStepInto<cr>")
	utils.keymap("n", { "<leader>dk", "<up>" }, "<cmd>DapStepOut<cr>")
	utils.keymap("n", "<leader>dt", "<cmd>DapTerminate<cr>")
	utils.keymap("n", { "]b", "]<c-b>" }, function()
		require("goto-breakpoints").next()
	end)
	utils.keymap("n", { "[b", "[<c-b>" }, function()
		require("goto-breakpoints").prev()
	end)

	-- List of install name
	-- https://github.com/jayp0521/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
	dap_setup.setup({
		handlers = {
			python = function(config)
				config.adapters = {
					command = "debugpy-adapter",
					type = "executable",
				}
				dap_setup.default_setup(config)
			end,
		},
	})

	dapui.setup({
		icons = { expanded = "", collapsed = "", current_frame = "" },
		mappings = {
			expand = { "<cr>", "l", "h" },
			open = "o",
			remove = "d",
			edit = "e",
			toggle = "t",
		},
		element_mappings = { stacks = { open = { "<cr>", "l", "h" }, expand = "o" } },
		layouts = {
			{
				elements = {
					{ id = "stacks", size = 0.4 },
					{ id = "watches", size = 0.6 },
				},
				size = 30,
				position = "left",
			},
		},
		controls = { enabled = false },
	})
	local group_name = "lDap"
	vim.api.nvim_create_augroup(group_name, { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "dapui_*",
		callback = function(opt)
			utils.buf_keymap(opt.buf, "n", "q", function()
				dapui.close()
			end)
		end,
		group = group_name,
	})
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "dap-repl",
		callback = function(opt)
			utils.buf_keymap(opt.buf, "n", "q", function()
				dap.repl.close()
			end)
		end,
		group = group_name,
	})
	theme.set_hl("DapUIVariable", { fg = theme.blender.fg_darker_2 })
	theme.set_hl("DapUIScope", { bold = true, fg = 4 })
	theme.set_hl("DapUIType", { link = "Type" })
	theme.set_hl("DapUIValue", { fg = theme.blender.bg_lighter_3 })
	theme.set_hl("DapUIModifiedValue", { fg = 15, underdashed = true })
	theme.set_hl("DapUIDecoration", { fg = theme.blender.bg_lighter_2 })
	theme.set_hl("DapUIType", { link = "Type" })
	theme.set_hl("DapUIStoppedThread", { bold = true, fg = 4 })
	theme.set_hl("DapUIThread", { fg = 4 })
	theme.set_hl("DapUISource", { fg = 12 })
	theme.set_hl("DapUILineNumber", { link = "Normal" })
	theme.set_hl("DapUIWatchesEmpty", { link = "Comment" })
	theme.set_hl("DapUIWatchesValue", { link = "Normal" })
	theme.set_hl("DapUIWatchesError", { link = "Comment" })
	theme.set_hl("DapUIBreakpointsCurrentLine", { fg = 2 })

	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end
end

function M.setup()
	require("mason").setup()
	require("mason-lock").setup()
	require("kitty-launcher").setup()
	setup_lsp_mappings()
	setup_dap()
end

-- LSP on_attach common invoke
function M.common_on_attach(_, bufnr)
	-- Insert keymap that might override default ones
	utils.buf_keymap(bufnr, "n", "gd", "<cmd>FzfLua lsp_definitions<cr>")
	utils.buf_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
	utils.buf_keymap(bufnr, "v", "=", ":'<,'>lua vim.lsp.buf.range_formatting()<cr>")
end

local jdtls_workspace = os.getenv("HOME") .. "/.java-workspace"

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
M.default_setup = {
	cssls = {
		on_attach = M.common_on_attach,
		capabilities = vim.tbl_extend(
			"keep",
			{ textDocument = { completion = { completionItem = { snippetSupport = true } } } },
			vim.lsp.protocol.make_client_capabilities()
		),
	},
	cssmodules_ls = { on_attach = M.common_on_attach },
	dockerls = { on_attach = M.common_on_attach },
	eslint = {
		on_attach = function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = true
			M.common_on_attach(client, bufnr)
		end,
	},
	html = {
		on_attach = M.common_on_attach,
		capabilities = vim.tbl_extend(
			"keep",
			{ textDocument = { completion = { completionItem = { snippetSupport = true } } } },
			vim.lsp.protocol.make_client_capabilities()
		),
	},
	jdtls = {
		-- Currently, jdtls latest version is not allowing Java 11 to be used
		-- To allow Java 11 to be used, we need to use the jdtls version the version that is supported
		-- To do so:
		--   :MasonInstall jdtls@1.9.0
		-- ref: https://github.com/williamboman/nvim-lsp-installer/issues/763
		on_attach = M.common_on_attach,
		use_lombok_agent = true,
		root_dir = function()
			return vim.fn.getcwd()
		end,
	},
	jsonls = {
		on_attach = M.common_on_attach,
		settings = {
			json = { schemas = require("schemastore").json.schemas() },
		},
		capabilities = vim.tbl_extend(
			"keep",
			{ textDocument = { completion = { completionItem = { snippetSupport = true } } } },
			vim.lsp.protocol.make_client_capabilities()
		),
	},
	ltex = (function()
		local dict_path = vim.fn.getcwd() .. "/.vim/ltex.dictionary.en-US.txt"
		local words = {}
		if vim.fn.filereadable(dict_path) == 1 then
			for word in io.open(dict_path, "r"):lines() do
				table.insert(words, word)
			end
		end

		return {
			on_attach = function(client, bufnr)
				require("ltex_extra").setup({ path = vim.fn.getcwd() .. "/.vim/" })
				M.common_on_attach(client, bufnr)
			end,
			settings = { ltex = { dictionary = { ["en-US"] = words } } },
			root_dir = function()
				return vim.fn.getcwd()
			end,
		}
	end)(),
	lua_ls = {
		on_attach = function(client, bufnr)
			-- Use efm lua-format instead
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
			M.common_on_attach(client, bufnr)
		end,
		settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
				completion = { callSnippet = "Replace" },
				workspace = { checkThirdParty = false },
			},
		},
	},
	pyright = {
		on_attach = M.common_on_attach,
	},
	rust_analyzer = {
		on_attach = M.common_on_attach,
		capabilities = {
			textDocument = { completion = { completionItem = { snippetSupport = false } } },
		},
	},
	tailwindcss = {
		on_attach = M.common_on_attach,
		settings = { tailwindCSS = { emmetCompletions = true } },
	},
	ts_ls = {
		on_attach = function(client, bufnr)
			-- prefer eslint
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
			M.common_on_attach(client, bufnr)
		end,
		root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
	},
	yamlls = {
		on_attach = M.common_on_attach,
		settings = { yaml = { format = { enable = true } } },
	},
}

return M
