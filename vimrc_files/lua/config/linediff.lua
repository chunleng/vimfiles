local M = {}

function M.setup()
    -- :Linediff<cr> not <cmd> because we want to pick up the range
    vim.api.nvim_set_keymap("x", "<leader>d", ":Linediff<cr>",
                            {noremap = true, silent = true})
end

return M
