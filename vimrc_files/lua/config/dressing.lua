local M = {}

function M.setup()
    require('dressing').setup({
        input = {winblend = 15, min_width = 40},
        select = {
            backend = {"builtin"},
            builtin = {
                min_height = 1,
                max_height = 10,
                min_width = 0,
                max_width = 0.9
            }
        }
    })
    vim.cmd [[
        augroup Dressing
            autocmd!
            autocmd FileType DressingSelect nnoremap <buffer><silent><c-p> k
            autocmd FileType DressingSelect nnoremap <buffer><silent><c-n> j
            autocmd FileType DressingInput setlocal sidescrolloff=10
        augroup END
    ]]
end

return M
