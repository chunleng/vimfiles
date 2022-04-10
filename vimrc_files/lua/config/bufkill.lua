local M = {}

function M.setup()
    vim.g.BufKillCreateMappings = 0
    vim.api.nvim_set_keymap("", "<c-x>", "<cmd>BD!<cr>",
                            {noremap = true, silent = true})
end

return M
