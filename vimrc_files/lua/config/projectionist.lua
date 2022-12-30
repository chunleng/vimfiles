local M = {}

function M.setup()
    local utils = require('common-utils')
    utils.noremap('n', '<c-s>', '<cmd>A<cr>')
end

return M
