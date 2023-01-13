local M = {}

function M.setup()
    local utils = require('common-utils')
    utils.noremap("n", "<leader>gf", "<cmd>GBrowse<cr>")
    utils.noremap("n", "<leader>gb", '<cmd>Git blame<cr>')

    vim.cmd [[
        augroup FugitiveFiletype
            autocmd!
            autocmd FileType fugitiveblame nnoremap <buffer> q <cmd>bd<cr>
        augroup END
    ]]
end

return M
