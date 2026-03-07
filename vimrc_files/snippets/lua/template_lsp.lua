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
	local rust_config = {
		["app/frontend"] = {
			target = "wasm32-unknown-unknown",
			features = { "web" },
			noDefaultFeatures = true,
		},
		-- With example
		["app//example"] = {},
		-- Catchall
		["*"] = {},
	}
	vim.lsp.config(
		"rust_analyzer",
		vim.tbl_extend("keep", {
			before_init = require("mod.lsp.rust_analyzer").override_check_parameters(rust_config),
		}, require("mod.lsp_config").rust_analyzer)
	)
	vim.lsp.config("taplo", require("mod.lsp_config").taplo)
	vim.lsp.enable({"rust_analyzer", "taplo"})
	require("null-ls").setup({
		root_dir = function()
			vim.fn.getcwd()
		end,
		sources = vim.list_extend(require("mod.lsp.none_ls.sources").cargo_checks(rust_config), {
			-- Activate when necessary
			-- require("null-ls").builtins.formatting.leptosfmt
			-- require("null-ls").builtins.formatting.dxfmt
		}),
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
	vim.lsp.config("taplo", require("mod.lsp_config").taplo)
	vim.lsp.enable({"taplo"})
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
	vim.lsp.config("protols", require("mod.lsp_config").protols)
	vim.lsp.enable({"protols"})
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "----lsp/terraform/init", dscr = "Template for terraform lsp" },
		fmta(
			[[
	vim.lsp.config("terraform_ls", require("mod.lsp_config").terraform_ls)
	vim.lsp.enable({"terraform_ls"})
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "----lsp/kubernetes/init", dscr = "Template for k8s lsp (yamlls)" },
		fmta(
			[[
-- Since kubernetes version is complicated, it needs a specialized schema to ensure version correctness
-- The setup is by no means an exhaustive list of yaml, so add more as needed
-- https://github.com/yannh/kubernetes-json-schema/tree/master/v1.<>-standalone
function k8s(kind)
	return string.format(
		"https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.<>-standalone/%s.json",
		kind
	)
end
vim.lsp.config(
	"yamlls",
	vim.tbl_extend("keep", {
		settings = {
			yaml = {
				schemas = {
					["https://www.schemastore.org/kustomization.json"] = "k8s/**/kustomization.{yml,yaml}",
					[k8s("deployment")] = "k8s/**/deployment.{yml,yaml}",
					[k8s("service")] = "k8s/**/service.{yml,yaml}",
					[k8s("pod")] = "k8s/**/pod.{yml,yaml}",
					[k8s("configmap")] = "k8s/**/configmap.{yml,yaml}",
					[k8s("patch")] = "k8s/**/patch/*.{yml,yaml}",
				},
			},
		},
	}, require("mod.lsp_config").yamlls)
)
vim.lsp.enable("yamlls")
]],
			{ i(1, "30.0"), l(l._1, 1) }
		)
	)
)

return M
-- vim: noet
