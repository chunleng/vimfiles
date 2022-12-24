local M = {}

function M.setup()
    vim.g.user_emmet_install_global = 0

    local utils = require('common-utils')
    utils.noremap("i", "<c-;>", "<c-o>dd<c-o>O<c-o>:Emmet <c-r>\"<cr>")
    utils.noremap("n", "<c-;>", ":Emmet ", false)
end

return M
