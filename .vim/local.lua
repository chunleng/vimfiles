local group_name = 'SaveAction'
vim.api.nvim_create_augroup(group_name, {clear = true})
vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = 0,
    callback = function() vim.lsp.buf.format({timeout_ms = 5000}) end,
    group = group_name
})
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = '*.lua',
    callback = function()
        vim.cmd('source <afile>')
        for _, client in ipairs(vim.lsp.get_active_clients()) do
            if client.config.name == 'lua_ls' then client.stop() end
        end
        vim.cmd('PackerCompile')
    end,
    group = group_name
})
