local M = {}

function M.setup()
    local sj = require('treesj')
    sj.setup({use_default_keymaps = false, max_join_length = 999})
    local utils = require('common-utils')

    -- <c-s-=> is equal to <c-+>
    utils.keymap({'n', 'i'}, '<c-s-=>', function() sj.split() end)
    utils.keymap({'n', 'i'}, '<c-->', function() sj.join() end)
end

return M
