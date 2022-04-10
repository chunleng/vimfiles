local M = {}

function M.setup()
    vim.g["test#strategy"] = "kitty"
    vim.g["test#preserve_screen"] = 1

    vim.api.nvim_set_keymap("n", "<leader>ctf", "<cmd>TestFile<cr>",
                            {noremap = true, silent = true})
    vim.api.nvim_set_keymap("n", "<leader>ctn", "<cmd>TestNearest<cr>",
                            {noremap = true, silent = true})
    vim.api.nvim_set_keymap("n", "<leader>ctt", "<cmd>TestSuite<cr>",
                            {noremap = true, silent = true})
end

return M
