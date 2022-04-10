local M = {}

function M.setup()
    vim.g.scrollview_winblend = 15
    vim.g.scrollview_column = 1
    vim.g.scrollview_excluded_filetypes = {"NvimTree", "WhichKey"}

    local base16 = require("base16-colorscheme")
    vim.highlight.create("ScrollView", {guibg = base16.colors.base0D_40}, false)
end

return M
