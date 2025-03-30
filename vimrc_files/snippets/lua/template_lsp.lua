local M = {}

table.insert(
	M,
	s(
		{ trig = "?lsp/css/init", dscr = "Template for css lsp" },
		fmta(
			[[
	require("lspconfig").cssls.setup(require("config.lsp").default_setup.cssls)
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "?lsp/docker/init", dscr = "Template for docker lsp" },
		fmta(
			[[
	require("lspconfig").dockerls.setup(require("config.lsp").default_setup.dockerls)
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "?lsp/html/init", dscr = "Template for html lsp" },
		fmta(
			[[
	require("lspconfig").html.setup(require("config.lsp").default_setup.html)
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "?lsp/java/init", dscr = "Template for java lsp" },
		fmta(
			[[
	require("lspconfig").jdtls.setup(require("config.lsp").default_setup.jdtls)
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "?lsp/javascript/init", dscr = "Template for javascript lsp" },
		fmta(
			[[
	require("lspconfig").cssmodules_ls.setup(require("config.lsp").default_setup.cssmodules_ls)
	require("lspconfig").eslint.setup(require("config.lsp").default_setup.eslint)
	require("lspconfig").ts_ls.setup(require("config.lsp").default_setup.ts_ls)
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "?lsp/json/init", dscr = "Template for json lsp" },
		fmta(
			[[
	require("lspconfig").jsonls.setup(require("config.lsp").default_setup.jsonls)
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "?lsp/lua/init", dscr = "Template for lua lsp" },
		fmta(
			[[
	require("neodev").setup()
	require("lspconfig").lua_ls.setup(require("config.lsp").default_setup.lua_ls)
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
		{ trig = "?lsp/markdown/init", dscr = "Template for markdown lsp" },
		fmta(
			[[
	require("lspconfig").ltex.setup(require("config.lsp").default_setup.ltex)
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
		{ trig = "?lsp/python/init", dscr = "Template for python lsp" },
		fmta(
			[[
	require("lspconfig").pyright.setup(require("config.lsp").default_setup.pyright)
	require("null-ls").setup({
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
		{ trig = "?lsp/rust/init", dscr = "Template for rust lsp" },
		fmta(
			[[
	require("lspconfig").rust_analyzer.setup(vim.tbl_extend("keep", {
		settings = {
			["rust-analyzer"] = {
				check = {
					overrideCommand = {
						"cargo",
						"check",
						"--quiet",
						"--message-format=json",
						-- "-p=ui",
					},
				},
			},
		},
	}, require("config.lsp").default_setup.rust_analyzer))
	require("null-ls").setup({
		sources = {
			method = require("null-ls").methods.FORMATTING,
			filetypes = { "rust" },
			generator = require("null-ls").formatter({
				async = false,
				command = "leptosfmt",
				to_stdin = true,
				args = { "-s" },
			}),
		},
	})
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "?lsp/tailwindcss/init", dscr = "Template for tailwindcss lsp" },
		fmta(
			[[
	require("lspconfig").tailwindcss.setup(
		vim.tbl_extend("keep", { filetypes = { "<>" } }, require("config.lsp").default_setup.tailwindcss)
	)
]],
			{ i(1, "html") }
		)
	)
)

return M
-- vim: noet
