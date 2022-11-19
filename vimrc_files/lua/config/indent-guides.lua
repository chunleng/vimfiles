local M = {}

function M.setup()
    local theme = require('common-theme')
    require("indent_guides").setup({
        indent_guide_size = 100,
        indent_tab_guides = true,
        exclude_filetypes = {
            'WhichKey', 'markdown', 'aerial', 'dashboard', 'help', 'fzf',
            'NvimTree', 'lsp-installer'
        },
        odd_colors = {
            fg = theme.colormap[theme.blender.fg_darker_1],
            bg = theme.colormap[theme.blender.bg_darker_1]
        },
        even_colors = {
            fg = theme.colormap[theme.blender.fg_darker_1],
            bg = 'none'
        }
    })
end

return M
