local M = {}

function M.setup()
    vim.api.nvim_set_keymap("n", "<leader>u", "<cmd>MundoToggle<cr>",
                            {noremap = true, silent = true})
    vim.g.mundo_width = 30
    vim.g.mundo_header = 0
end

return M
