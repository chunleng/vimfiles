local constant = require("constant")

local function get_mason_path_with_nodejs()
	local mason_path = vim.env.HOME .. "/.local/share/nvim/mason/bin"
	return constant.NODEJS_PATH .. ":" .. mason_path .. ":" .. vim.env.PATH
end

local function load_ltex_dictionary()
	local dict_path = vim.fn.getcwd() .. "/.vim/ltex.dictionary.en-US.txt"
	local words = {}
	if vim.fn.filereadable(dict_path) == 1 then
		for word in io.open(dict_path, "r"):lines() do
			table.insert(words, word)
		end
	end

	return words
end

local function common_on_attach(_, bufnr)
	local utils = require("common-utils")

	-- Insert keymap that might override default ones
	utils.buf_keymap(bufnr, "n", "gd", "<cmd>FzfLua lsp_definitions<cr>")
	utils.buf_keymap(bufnr, "n", "K", function()
		vim.lsp.buf.hover()
	end)
	utils.buf_keymap(bufnr, "v", "=", function()
		local start_pos = vim.fn.getpos("'<")
		local end_pos = vim.fn.getpos("'>")

		vim.lsp.buf.format({
			range = {
				["start"] = { start_pos[2] - 1, start_pos[3] },
				["end"] = { end_pos[2] - 1, end_pos[3] },
			},
		})
	end)
end

-- We can use nvim-lspconfig to refer to how we can write sane configurations for use:
-- https://github.com/neovim/nvim-lspconfig/tree/master/lsp
return {
	cssls = {
		cmd = { "vscode-css-language-server", "--stdio" },
		filetypes = { "css", "scss", "less" },
		init_options = { provideFormatter = true },
		on_attach = common_on_attach,
		settings = {
			css = { validate = true },
			scss = { validate = true },
			less = { validate = true },
		},
		root_markers = { ".git" },
	},
	cssmodules_ls = {
		cmd = { "cssmodules-language-server" },
		filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		root_markers = { "package.json" },
		on_attach = common_on_attach,
	},
	dockerls = {
		cmd = { "docker-langserver", "--stdio" },
		filetypes = { "dockerfile" },
		root_markers = { "Dockerfile" },
		on_attach = common_on_attach,
		cmd_env = {
			PATH = get_mason_path_with_nodejs(),
		},
	},
	eslint = {
		cmd = { "vscode-eslint-language-server", "--stdio" },
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
		},
		workspace_required = true,
		on_attach = common_on_attach,
		settings = {
			validate = "on",
			experimental = {
				useFlatConfig = false,
			},
			format = true,
			rulesCustomizations = {},
			run = "onType",
			problems = {
				shortenToSingleLine = false,
			},
			nodePath = "",
			codeAction = {
				disableRuleComment = {
					enable = true,
					location = "separateLine",
				},
			},
			workspaceFolder = {
				uri = vim.fn.getcwd(),
			},
		},
		root_dir = function(_, on_dir)
			on_dir(vim.fn.getcwd())
		end,
	},
	html = {
		cmd = { "vscode-html-language-server", "--stdio" },
		filetypes = { "html" },
		root_markers = { "package.json", ".git" },
		on_attach = common_on_attach,
		init_options = {
			provideFormatter = true,
			embeddedLanguages = { css = true, javascript = true },
			configurationSection = { "html", "css", "javascript" },
		},
	},
	jdtls = {
		-- Currently, jdtls latest version is not allowing Java 11 to be used
		-- To allow Java 11 to be used, we need to use the jdtls version the version that is supported
		-- To do so:
		--   :MasonInstall jdtls@1.9.0
		-- ref: https://github.com/williamboman/nvim-lsp-installer/issues/763
		cmd = { "jdtls", "-data", vim.fn.getcwd() .. "/.jdtls" },
		filetypes = { "java" },
		on_attach = common_on_attach,
		use_lombok_agent = true,
		root_markers = { "build.gradle", ".git" },
	},
	jsonls = {
		cmd = { "vscode-json-language-server", "--stdio" },
		filetypes = { "json", "jsonc" },
		init_options = {
			provideFormatter = true,
		},
		root_markers = { ".git" },
		on_attach = common_on_attach,
		settings = {
			json = { schemas = require("schemastore").json.schemas() },
		},
		cmd_env = {
			PATH = get_mason_path_with_nodejs(),
		},
	},
	ltex_plus = {
		cmd = { "ltex-ls-plus" },
		filetypes = { "gitcommit", "html", "markdown", "text" },
		single_file_support = true,
		get_language_id = function(_, filetype)
			local mapping = {
				text = "plaintext",
			}
			return mapping[filetype] or filetype
		end,
		settings = {
			ltex = {
				enabled = { "gitcommit", "html", "markdown", "text" },
				dictionary = { ["en-US"] = load_ltex_dictionary() },
			},
		},
		on_attach = function(client, bufnr)
			require("ltex_extra").setup({ path = vim.fn.getcwd() .. "/.vim/" })
			common_on_attach(client, bufnr)
		end,
		cmd_env = {
			JAVA_HOME = constant.JAVA_HOME,
			ASDF_JAVA_VERSION = constant.JAVA_VERSION,
		},
	},
	lua_ls = {
		cmd = { "lua-language-server" },
		on_attach = function(client, bufnr)
			-- Use stylua instead
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
			common_on_attach(client, bufnr)
		end,
		filetypes = { "lua" },
		root_markers = { ".git" },
	},
	protols = {
		on_attach = common_on_attach,
	},
	pyright = {
		cmd = { "pyright-langserver", "--stdio" },
		filetypes = { "python" },
		on_attach = common_on_attach,
		cmd_env = {
			PATH = get_mason_path_with_nodejs(),
		},
		settings = {
			python = {
				analysis = {
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
					diagnosticMode = "openFilesOnly",
				},
			},
		},
		root_markers = { "pyproject.toml", ".git" },
	},
	rust_analyzer = {
		cmd = { "rust-analyzer" },
		filetypes = { "rust" },
		on_attach = common_on_attach,
		capabilities = { textDocument = { completion = { completionItem = { snippetSupport = false } } } },
		settings = {
			["rust-analyzer"] = {
				check = {
					workspace = false,
				},
			},
		},
		handlers = {
			-- Silent unsupported function
			["workspace/diagnostic/refresh"] = function()
				return {}
			end,
		},
		cmd_env = {
			ASDF_RUST_VERSION = (function()
				local handle = io.popen("cargo --version")
				if handle then
					local result = handle:read("*a")
					handle:close()
					local version = result:match("(%d+%.%d+%.%d+)")
					return version
				end
				return ""
			end)(),
		},
		root_markers = { "Cargo.toml", ".git" },
	},
	tailwindcss = {
		cmd = { "tailwindcss-language-server", "--stdio" },
		filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
		capabilities = { workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } },
		on_attach = common_on_attach,
		workspace_required = true,
		root_dir = function(_, on_dir)
			on_dir(vim.fn.getcwd())
		end,
	},
	taplo = {
		cmd = { "taplo", "lsp", "stdio" },
		on_attach = common_on_attach,
		filetypes = { "toml" },
		root_markers = { ".git" },
	},
	ts_ls = {
		cmd = { "typescript-language-server", "--stdio" },
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
		},
		init_options = { hostInfo = "neovim" },
		on_attach = function(client, bufnr)
			-- prefer eslint
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
			common_on_attach(client, bufnr)
		end,
		root_markers = { "package.json" },
	},
	yamlls = {
		cmd = { "yaml-language-server", "--stdio" },
		filetypes = { "yaml" },
		on_attach = function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = true
			common_on_attach(client, bufnr)
		end,
		settings = { yaml = { format = { enable = true } } },
		cmd_env = {
			PATH = get_mason_path_with_nodejs(),
		},
		root_markers = { ".git" },
	},
}
