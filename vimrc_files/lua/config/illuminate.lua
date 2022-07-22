local M = {}

function M.setup()
    vim.g.Illuminate_ftblacklist = {
        "dashboard", "NvimTree", "aerial", "lsp-installer"
    }
end

return M
