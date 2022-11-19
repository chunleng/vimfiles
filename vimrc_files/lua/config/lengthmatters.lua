local M = {}

function M.setup()
    vim.api.nvim_set_keymap("n", "<leader>to", "<cmd>LengthmattersToggle<cr>",
                            {noremap = true, silent = true})
    vim.g.lengthmatters_excluded = {
        "Mundo", "MundoDiff", "NvimTree", "help", "qf", "WhichKey", "min",
        "markdown", "dashboard", "dbout", "lsp-installer"
    }
    vim.fn.call("lengthmatters#highlight_link_to", {'ColorColumn'})
end

return M
