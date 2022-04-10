local M = {}

function M.setup()
    vim.api.nvim_set_keymap("n", "!ru", "<cmd>UltiSnipsEdit!<cr>",
                            {noremap = true, silent = true})
    vim.g.UltiSnipsJumpForwardTrigger = "<c-j>"
    vim.g.UltiSnipsJumpBackwardTrigger = "<c-k>"

    vim.cmd [[
        augroup snippets
            autocmd!
            autocmd FileType snippets setlocal foldlevel=0
        augroup END
    ]]
end

return M
