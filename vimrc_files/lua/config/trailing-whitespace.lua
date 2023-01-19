local M = {}

function M.setup()
    vim.g.extra_whitespace_ignored_filetypes = {
        "Mundo", "MundoDiff", "aerial", "dashboard", "dbout", "dbui", "fzf",
        "lspinfo", "help", 'mason', "", 'neotest-summary', 'fugitiveblame',
        'git'
    }

    local theme = require('common-theme')
    theme.set_hl('ExtraWhitespace',
                 {fg = 3, bold = true, bg = theme.blender.bg_lighter_2})
end

return M
