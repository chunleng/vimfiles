local M = {}

function M.setup()
    local utils = require('common-utils')
    utils.noremap("n", "<leader>tc", "<cmd>ColorizerToggle<cr>")
    require'colorizer'.setup({user_default_options = {names = false}})
end

return M
