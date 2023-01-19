local M = {}

function M.setup()
    vim.g.extra_whitespace_ignored_filetypes = {
        "Mundo", "MundoDiff", "aerial", "dashboard", "dbout", "dbui", "fzf",
        "lspinfo", "help", 'mason', "", 'neotest-summary', 'fugitiveblame',
        'git'
    }
end

return M
