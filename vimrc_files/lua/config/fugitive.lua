local M = {}

function M.setup()
    vim.api.nvim_set_keymap("n", "<leader>gf", "<cmd>GBrowse<cr>",
                            {noremap = true, silent = true})
    vim.api.nvim_set_keymap("n", "<leader>gb", "<cmd>Git blame<cr>",
                            {noremap = true, silent = true})
end

return M
