local M = {}

function M.setup()
    vim.api.nvim_set_keymap("n", "<leader>cc", "<cmd>SymbolsOutline<cr>",
                            {noremap = true, silent = true})

end

return M
