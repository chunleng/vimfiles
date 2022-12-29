local M = {}

function M.setup()
    vim.g.bullets_enabled_file_types = {
        'markdown', 'text', 'gitcommit', 'scratch'
    }
    vim.g.bullets_set_mappings = 0
    vim.g.bullets_custom_mappings = {
        {'nnoremap', 'o', '<plug>(bullets-newline)'},
        {'inoremap', '<c-d>', '<plug>(bullets-promote)'},
        {'nnoremap', '<<', '<plug>(bullets-promote)'},
        {'vnoremap', '<', '<plug>(bullets-promote)'},
        {'inoremap', '<c-t>', '<plug>(bullets-demote)'},
        {'nnoremap', '>>', '<plug>(bullets-demote)'},
        {'vnoremap', '>', '<plug>(bullets-demote)'}
    }
end

return M
