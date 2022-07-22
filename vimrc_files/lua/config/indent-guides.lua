local M = {}

function M.setup()
    local base16 = require("base16-colorscheme")
    require("indent_guides").setup({
        indent_guide_size = 100,
        indent_tab_guides = true,
        exclude_filetypes = {
            'WhichKey', 'markdown', 'aerial', 'dashboard', 'help', 'fzf',
            'NvimTree', 'lsp-installer'
        },
        odd_colors = {fg = base16.colors.base03, bg = base16.colors.base00_15},
        even_colors = {fg = base16.colors.base03, bg = base16.colors.base00}
    })
end

return M
