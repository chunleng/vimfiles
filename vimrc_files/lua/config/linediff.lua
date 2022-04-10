local M = {}

function M.setup()
    vim.api.nvim_set_keymap("v", "<leader>d", "<cmd>Linediff<cr>",
                            {noremap = true, silent = true})
end

return M
