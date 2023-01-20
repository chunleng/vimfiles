local M = {}

function M.setup()
    local utils = require('common-utils')
    utils.keymap('n', '<c-\\>', function()
        if vim.fn.exists(':A') == 2 then
            xpcall(function(var_a) vim.cmd('A') end,
                   function(err) print('No alternative file') end)
        end
    end)
end

return M
