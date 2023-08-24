local M = {}

function M.setup()
    vim.g.ai_no_mappings = true
    vim.g.ai_indicator_text = '󱚤 '
    vim.g.ai_context_after = 5

    local utils = require('common-utils')
    utils.keymap('n', '<c-space>', '<cmd>normal o<cr>:AI ', {silent = false})
    utils.keymap('v', '<c-space>', ':AI ', {silent = false})
    utils.keymap('i', '<c-space>', '<esc><cmd>:AI<cr>o', {silent = false})
end

return M
