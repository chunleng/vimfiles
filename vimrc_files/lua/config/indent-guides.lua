local M = {}

function M.setup()
    local base16 = require("base16-colorscheme")
    require("indent_guides").setup({
        indent_guide_size = 100,
        indent_tab_guides = true,
        indent_pretty_mode = true,
        exclude_filetypes = {
            'WhichKey', 'markdown', 'aerial', 'dashboard', 'help', 'fzf'
        },
        odd_colors = {fg = base16.colors.base03, bg = base16.colors.base00_15},
        even_colors = {fg = base16.colors.base03, bg = base16.colors.base00}
    })
    -- vim.api.nvim_set_keymap("n", "za",
    --                         "za:IndentBlanklineRefresh<cr>:ScrollViewRefresh<cr>",
    --                         {silent = true, noremap = true})
    -- vim.api.nvim_set_keymap("v", "za",
    --                         "za:IndentBlanklineRefresh<cr>:ScrollViewRefresh<cr>",
    --                         {silent = true, noremap = true})
    -- vim.highlight.create("IndentBlanklineChar", {guifg = base16.colors.base02},
    --                      false)
end

return M
