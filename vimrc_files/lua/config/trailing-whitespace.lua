local M = {}

function M.setup()
    vim.g.extra_whitespace_ignored_filetypes = {
        "Mundo", "MundoDiff", "Outline", "dashboard", "dbout", "dbui"
    }
end

return M
