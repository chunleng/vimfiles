local M = {}

function M.setup()
    vim.g.ai_no_mappings = true
    vim.g.ai_indicator_text = ''

    local utils = require('common-utils')
    utils.noremap('n', '<c-space>', '<cmd>normal o<cr>:AI ', false)
    utils.noremap('v', '<c-space>', ':AI ', false)
    utils.noremap('i', '<c-space>', '<esc><cmd>:AI<cr>o', false)
end

return M
