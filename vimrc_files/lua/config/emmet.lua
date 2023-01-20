local M = {}

function M.setup()
    vim.g.user_emmet_install_global = 1
    vim.g.emmet_install_only_plug = 1

    local utils = require('common-utils')
    utils.keymap('n', '<c-enter>', ':Emmet ', {silent = false})
end

return M
