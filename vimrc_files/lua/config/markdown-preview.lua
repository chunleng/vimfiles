local M = {}

function M.setup()
    vim.cmd "autocmd FileType markdown nnoremap <silent><buffer><leader>tm :MarkdownPreviewToggle<cr>"
    vim.g.mkdp_auto_close = 0
end

return M
