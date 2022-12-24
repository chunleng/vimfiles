local M = {}

function M.setup()
    local utils = require('common-utils')
    utils.noremap("n", "!ru", "<cmd>UltiSnipsEdit!<cr>")
    vim.g.UltiSnipsJumpForwardTrigger = "<c-j>"
    vim.g.UltiSnipsJumpBackwardTrigger = "<c-k>"

    vim.cmd [[
        augroup snippets
            autocmd!
            autocmd FileType snippets setlocal foldlevel=0
        augroup END
    ]]
end

return M
