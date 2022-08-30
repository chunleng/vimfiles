local M = {}

function M.setup()
    vim.api.nvim_set_keymap("n", "<leader>tc", ":ColorizerToggle<cr>",
                            {silent = true})
    require'colorizer'.setup({}, {names = false})
end

return M
