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
