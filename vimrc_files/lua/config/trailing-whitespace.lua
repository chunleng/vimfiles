local M = {}

function M.setup()
    vim.g.extra_whitespace_ignored_filetypes = {
        "Mundo", "MundoDiff", "aerial", "dashboard", "dbout", "dbui", "fzf", ""
    }
end

return M
