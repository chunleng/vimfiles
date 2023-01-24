local M = {}

function M.setup()
    require('Comment').setup({mappings = {basic = false, extra = false}})
    local api = require('Comment.api')
    local utils = require('common-utils')
    utils.keymap({'i', 'n'}, '<c-/>', api.toggle.linewise.current)
    utils.keymap('x', '<c-/>', function()
        vim.fn.eval('feedkeys("\\<esc>", "nx")')
        api.toggle.linewise(vim.fn.visualmode())
    end)
end

return M
