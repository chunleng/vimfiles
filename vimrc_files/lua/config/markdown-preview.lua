local M = {}

function M.setup()
    vim.cmd "autocmd FileType markdown,plantuml nnoremap <silent><buffer><leader>tm :MarkdownPreviewToggle<cr>"
    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_filetypes = {'markdown', 'plantuml'}
end

return M
