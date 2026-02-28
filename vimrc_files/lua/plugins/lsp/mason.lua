local constant = require("constant")

local function setup_mason_sync_command()
	vim.api.nvim_create_user_command("MasonSync", function()
		local reg = require("mason-registry")
		local packages = reg.get_installed_packages()
		local version_lookup = {}

		for _, new_path in ipairs({
			constant.NODEJS_PATH,
			constant.PYTHON_PATH,
			constant.RUST_PATH,
		}) do
			vim.fn.setenv("PATH", new_path .. ":" .. vim.fn.getenv("PATH"))
		end
		vim.notify(
			"PATH environment has been altered for :MasonInstall to work, this causes some changes in binary priority",
			vim.log.levels.WARN
		)

		for _, package in ipairs(packages) do
			local version = package:get_installed_version()
			version_lookup[package.spec.name] = version
		end

		local install_list = {
			{ name = "css-lsp", version = "4.10.0" },
			{ name = "cssmodules-language-server", version = "1.5.1" },
			{ name = "debugpy", version = "1.8.14" },
			{ name = "dockerfile-language-server", version = "0.14.0" },
			{ name = "eslint-lsp", version = "4.10.0" },
			{ name = "html-lsp", version = "4.10.0" },
			{ name = "jdtls", version = "v1.46.1" },
			{ name = "json-lsp", version = "4.10.0" },
			{ name = "ltex-ls-plus", version = "18.6.1" },
			{ name = "lua-language-server", version = "3.15.0" },
			{ name = "protols", version = "0.12.7" },
			{ name = "pyright", version = "1.1.403" },
			{ name = "rust-analyzer", version = "2026-02-23" },
			{ name = "tailwindcss-language-server", version = "0.14.25" },
			{ name = "taplo", version = "0.10.0" },
			{ name = "terraform-ls", version = "v0.36.5" },
			{ name = "typescript-language-server", version = "4.3.4" },
			{ name = "vim-language-server", version = "2.3.1" },
			{ name = "yaml-language-server", version = "1.18.0" },
			{ name = "zk", version = "v0.15.1" },
		}
		for _, item in ipairs(install_list) do
			local installed_version = version_lookup[item.name]
			if installed_version == nil or installed_version ~= item.version then
				vim.cmd("MasonInstall --force " .. item.name .. "@" .. item.version)
			end
		end
	end, { desc = "Sync Mason version to lock version" })
end

local function setup()
	require("mason").setup({
		registries = {
			"github:mason-org/mason-registry@2025-07-14-wild-lightning",
		},
	})

	setup_mason_sync_command()
end

return {
	{
		-- https://github.com/williamboman/mason.nvim
		"williamboman/mason.nvim",
		config = setup,
	},
}
