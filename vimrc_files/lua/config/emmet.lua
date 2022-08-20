local M = {}

function M.setup()
    vim.g.user_emmet_install_global = 0

    vim.api.nvim_set_keymap("i", "<c-;>",
                            "<c-o>dd<c-o>O<c-o>:Emmet <c-r>\"<cr>",
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap("n", "<c-;>", ":Emmet ", {noremap = true})
end

return M
