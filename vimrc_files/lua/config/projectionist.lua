local M = {}

function M.setup()
    local utils = require('common-utils')
    utils.noremap('n', '<c-s>', function()
        if vim.fn.exists(':A') == 2 then vim.cmd('A') end
    end)
end

return M
