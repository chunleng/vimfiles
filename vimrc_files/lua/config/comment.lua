local M = {}

function M.setup()
    require('Comment').setup({
        sticky = false,
        mappings = {basic = false, extra = false},
        pre_hook = function()
            M.count = #vim.api.nvim_get_current_line()
            M.cursor_col = vim.api.nvim_win_get_cursor(0)[2]
        end,
        post_hook = function()
            local cnt_change = #vim.api.nvim_get_current_line() - M.count
            local cursor = vim.api.nvim_win_get_cursor(0)
            local cursor_change = cursor[2] - M.cursor_col

            cursor[2] = cursor[2] + cnt_change - cursor_change
            vim.api.nvim_win_set_cursor(0, cursor)
        end
    })

    local api = require('Comment.api')
    local utils = require('common-utils')
    utils.keymap({'i', 'n'}, '<c-/>', api.toggle.linewise.current)
    utils.keymap('x', '<c-/>', function()
        vim.fn.eval('feedkeys("\\<esc>", "nx")')
        api.toggle.linewise(vim.fn.visualmode())
    end)
end

return M
