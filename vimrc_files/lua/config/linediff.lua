local M = {}

function M.setup()
    local utils = require('common-utils')
    -- :Linediff<cr> not <cmd> because we want to pick up the range
    utils.noremap("x", "<leader>d", "<cmd>Linediff<cr>")
end

return M
