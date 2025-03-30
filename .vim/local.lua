------------------------------
-- Load every buffer change --
------------------------------

if vim.g.localvimrc_sourced_once_for_file == 1 then
	return
end
-----------------------------
-- Load once for each file --
-----------------------------

if vim.g.localvimrc_sourced_once == 1 then
	return
end
--------------------------------
-- Load once per vim instance --
--------------------------------
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		vim.lsp.buf.format({ timeout_ms = 5000 })
	end,
})

require("neodev").setup()
require("lspconfig").lua_ls.setup(require("config.lsp").default_setup.lua_ls)
require("null-ls").setup({ sources = {
	require("null-ls").builtins.formatting.stylua,
} })
