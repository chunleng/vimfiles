local M = {}

function M.setup()
    require('indent_blankline').setup({char_highlight_list = {'whitespace'}})
end

return M
