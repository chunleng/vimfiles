local group_name = 'SaveAction'
vim.api.nvim_create_augroup(group_name, {clear = true})
vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = 0,
    callback = function() vim.lsp.buf.format({timeout_ms = 5000}) end,
    group = group_name
})
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = '*.lua',
    command = 'source <afile> | PackerCompile',
    group = group_name
})
-- :h dadbod

vim.g.dbs = {
    {name = "dev-pg", url = "postgres://postgres:password@localhost:5432/db"}, {
        name = "dev-mysql",
        url = "mysql://mysql:password@127.0.0.1:3306/db?default-character-set=utf8"
    }
}
