local M = {}

function M.setup()
    vim.g.ai_no_mappings = true
    vim.g.ai_indicator_text = ''

    vim.api.nvim_set_keymap('n', '<c-e>', ':AI ', {noremap = true})
    vim.api.nvim_set_keymap('v', '<c-e>', ':AI ', {noremap = true})
    vim.api.nvim_set_keymap('i', '<c-space>', '<c-o>:AI ',
                            {silent = true, noremap = true})
end

return M
