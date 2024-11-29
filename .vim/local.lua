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

local group_name = 'SaveAction'
vim.api.nvim_create_augroup(group_name, {clear = true})
vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = 0,
    callback = function() vim.lsp.buf.format({timeout_ms = 5000}) end,
    group = group_name
})
