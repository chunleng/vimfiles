local M = {}

table.insert(
	M,
	s(
		{ trig = "----lsp/css/init", dscr = "Template for css lsp" },
		fmta(
			[[
	vim.lsp.config("cssls", require("mod.lsp_config").cssls)
	vim.lsp.enable("cssls")
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "----lsp/docker/init", dscr = "Template for docker lsp" },
		fmta(
			[[
	vim.lsp.config("dockerls", require("mod.lsp_config").dockerls)
	vim.lsp.enable("dockerls")
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "----lsp/html/init", dscr = "Template for html lsp" },
		fmta(
			[[
	vim.lsp.config("html", require("mod.lsp_config").html)
	vim.lsp.enable("html")
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "----lsp/java/init", dscr = "Template for java lsp" },
		fmta(
			[[
	vim.lsp.config("jdtls", require("mod.lsp_config").jdtls)
	vim.lsp.enable("jdtls")
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "----lsp/javascript/init", dscr = "Template for javascript lsp" },
		fmta(
			[[
	vim.lsp.config("cssmodules_ls", require("mod.lsp_config").cssmodules_ls)
	vim.lsp.config("eslint", require("mod.lsp_config").eslint)
	vim.lsp.config("ts_ls", require("mod.lsp_config").ts_ls)
	vim.lsp.enable({"cssmodules_ls", "eslint", "ts_ls"})
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "----lsp/json/init", dscr = "Template for json lsp" },
		fmta(
			[[
	vim.lsp.config("jsonls", require("mod.lsp_config").jsonls)
	vim.lsp.enable("jsonls")
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "----lsp/lua/init", dscr = "Template for lua lsp" },
		fmta(
			[[
	vim.lsp.config("lua_ls", require("mod.lsp_config").lua_ls)
	vim.lsp.enable("lua_ls")
	require("null-ls").setup({ sources = {
		require("null-ls").builtins.formatting.stylua,
	} })
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "----lsp/markdown/init", dscr = "Template for markdown lsp" },
		fmta(
			[[
	vim.lsp.config("ltex_plus", require("mod.lsp_config").ltex_plus)
	vim.lsp.enable("ltex_plus")
	require("null-ls").setup({
		sources = {
			require("null-ls").builtins.diagnostics.markdownlint
		}
	})
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "----lsp/python/init", dscr = "Template for python lsp" },
		fmta(
			[[
	vim.lsp.config("pyright", require("mod.lsp_config").pyright)
	vim.lsp.config("taplo", require("mod.lsp_config").taplo)
	vim.lsp.enable({"pyright", "taplo"})

	require("null-ls").setup({
		root_dir = function() vim.fn.getcwd() end,
		sources = {
			-- require("null-ls").builtins.formatting.yapf,
			-- require("null-ls").builtins.formatting.black,
			-- require("null-ls").builtins.formatting.isort,
			-- require("null-ls").builtins.diagnostics.pylint,
			-- require("null-ls").builtins.diagnostics.mypy,
			-- require("none-ls.formatting.ruff"),
			-- require("none-ls.formatting.ruff_format"),
			-- require("none-ls.diagnostics.ruff"),
		}
	})
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "----lsp/rust/init", dscr = "Template for rust lsp" },
		fmta(
			[[
	vim.lsp.config(
		"rust_analyzer",
		vim.tbl_extend("keep", {
			-- before_init = function(init_params, config)
			-- 	local cwd = vim.fn.getcwd()
			--
			-- 	-- Out of the project files cargo will be left as is
			-- 	if init_params.rootPath:sub(1, #cwd) ~= cwd then
			-- 		config.settings["rust-analyzer"].cargo = {}
			-- 		return
			-- 	end
			--
			-- 	-- Default for all projects, we can manually switch this if we want to develop for a different feature or target
			-- 	local cargo = {
			-- 		features = {
			-- 			"client",
			-- 			"backend",
			-- 		},
			-- 		target = "wasm32-unknown-unknown"
			-- 	}
			-- 	-- Conditionally, we can also set different features/target for different workspace member
			-- 	local path_from_root = init_params.rootPath:sub(#cwd + 1)
			-- 	if path_from_root == "/tests/sample-test-backend" then
			-- 		cargo.features = { "backend" }
			-- 	end
			-- 	config.settings["rust-analyzer"].cargo =
			-- 		vim.tbl_extend("force", config.settings["rust-analyzer"].cargo or {}, cargo)
			-- end,
		}, require("mod.lsp_config").rust_analyzer)
	)
	vim.lsp.config("taplo", require("mod.lsp_config").taplo)
	vim.lsp.enable({"rust_analyzer", "taplo"})

	require("null-ls").setup({
		root_dir = function() vim.fn.getcwd() end,
		sources = {
			-- Activate when necessary
			-- require("null-ls").builtins.formatting.leptosfmt
			-- require("null-ls").builtins.formatting.dxfmt
		}
	})
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "----lsp/tailwindcss/init", dscr = "Template for tailwindcss lsp" },
		fmta(
			[[
	vim.lsp.config(
		"tailwindcss",
		vim.tbl_extend("keep", {
			-- filetypes = { "rust" },
			settings = {
				tailwindCSS = {
					-- Dioxus setting
					-- experimental = {
					-- 	classRegex = {"class: \"(.*)\""}
					-- }
				}
			},
		}, require("mod.lsp_config").tailwindcss)
	)
	vim.lsp.enable("tailwindcss")
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "----lsp/yaml/init", dscr = "Template for yaml lsp" },
		fmta(
			[[
	vim.lsp.config(
		"yamlls",
		vim.tbl_extend("keep", {
			settings = {
				yaml = {
					schemas = {
						-- ["https://www.schemastore.org/..."] = "**/*.{yml,yaml}"
					}
				}
			},
		}, require("mod.lsp_config").yamlls)
	)
	vim.lsp.enable("yamlls")

]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "----lsp/toml/init", dscr = "Template for toml lsp" },
		fmta(
			[[
	require("lspconfig").taplo.setup(require("config.lsp").default_setup.taplo)
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "----lsp/protobuf/init", dscr = "Template for protobuf lsp" },
		fmta(
			[[
	require("lspconfig").protols.setup(require("config.lsp").default_setup.protols)
]],
			{}
		)
	)
)

return M
-- vim: noet
