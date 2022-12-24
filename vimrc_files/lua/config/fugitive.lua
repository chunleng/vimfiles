local M = {}

function M.setup()
    vim.api.nvim_set_keymap("n", "<leader>gf", "<cmd>GBrowse<cr>",
                            {noremap = true, silent = true})
    vim.keymap.set("n", "<c-w><c-g>", function()
        vim.ui.select({'blame', 'browse file'}, {prompt = 'Git Menu'},
                      function(choice)
            if choice == 'blame' then
                vim.cmd("Git blame")
            elseif choice == 'browse file' then
                vim.cmd("GBrowse")
            end
        end)
    end, {noremap = true, silent = true})

    vim.cmd [[
        augroup lFiletype
            autocmd!
            autocmd FileType fugitiveblame nnoremap <buffer> q <cmd>bd<cr>
        augroup END
    ]]
end

return M
