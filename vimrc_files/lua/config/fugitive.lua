local M = {}

function M.setup()
    local utils = require('common-utils')
    utils.noremap("n", "<leader>gf", "<cmd>GBrowse<cr>")
    utils.noremap("n", "<c-w><c-g>", function()
        vim.ui.select({'blame', 'browse file'}, {prompt = 'Git Menu'},
                      function(choice)
            if choice == 'blame' then
                vim.cmd("Git blame")
            elseif choice == 'browse file' then
                vim.cmd("GBrowse")
            end
        end)
    end)

    vim.cmd [[
        augroup lFiletype
            autocmd!
            autocmd FileType fugitiveblame nnoremap <buffer> q <cmd>bd<cr>
        augroup END
    ]]
end

return M
