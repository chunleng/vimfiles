local M = {}

function M.setup()
    vim.g.ai_no_mappings = true
    vim.g.ai_indicator_text = ''

    vim.api.nvim_set_keymap('n', '<c-space>', '<cmd>normal o<cr>:AI ',
                            {noremap = true})
    vim.api.nvim_set_keymap('v', '<c-space>', ':AI ', {noremap = true})
    vim.api.nvim_set_keymap('i', '<c-space>', '<esc><cmd>:AI<cr>o',
                            {noremap = true})
end

return M
