local M = {}

function M.setup()
    vim.api.nvim_set_keymap("n", "<leader>tc", ":ColorizerToggle<cr>",
                            {silent = true})
    require'colorizer'.setup({user_default_options = {names = false}})
end

return M
