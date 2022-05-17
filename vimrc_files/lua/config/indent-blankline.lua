local M = {}

function M.setup()
    require("indent_blankline").setup {
        char = "│",
        filetype_exclude = {
            'WhichKey', 'markdown', 'Outline', 'dashboard', 'help'
        }
    }
    vim.api.nvim_set_keymap("n", "za",
                            "za:IndentBlanklineRefresh<cr>:ScrollViewRefresh<cr>",
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap("v", "za",
                            "za:IndentBlanklineRefresh<cr>:ScrollViewRefresh<cr>",
                            {silent = true, noremap = true})
    local base16 = require("base16-colorscheme")
    vim.highlight.create("IndentBlanklineChar", {guifg = base16.colors.base02},
                         false)
end

return M
