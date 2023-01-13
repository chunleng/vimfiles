local M = {}

function M.setup()
    require('gitsigns').setup {
        signs = {
            add = {hl = 'GitSignsAdd', text = ''},
            change = {hl = 'GitSignsChange', text = ''},
            delete = {hl = 'GitSignsDelete', text = ''},
            topdelete = {hl = 'GitSignsDelete', text = ''},
            changedelete = {hl = 'GitSignsChange', text = ''},
            untracked = {hl = 'GitSignsChange', text = ''}
        },
        on_attach = function(bufnr)
            local utils = require('common-utils')
            local gs = require('gitsigns.actions')
            utils.buf_noremap(bufnr, 'n', {'<leader>gn', '+'},
                              function() gs.next_hunk() end)
            utils.buf_noremap(bufnr, 'n', {'<leader>gp', '-'},
                              function() gs.prev_hunk() end)
            utils.buf_noremap(bufnr, 'n', {'<leader>gr'},
                              function() gs.reset_hunk() end)
            utils.buf_noremap(bufnr, 'n', {'<leader>gd'},
                              function() gs.diffthis() end)
        end,
        current_line_blame = true,
        current_line_blame_opts = {virt_text = true},
        current_line_blame_formatter = function(name, blame_info)
            local author = blame_info.author == name and "Me" or
                               blame_info.author
            return {
                {'	  ', 'Normal'}, {'  ', 'GitSignsCurrentLineBlameAccent'},
                {
                    string.format("%s on %s", author,
                                  os.date("%Y-%m-%d", blame_info.author_time)),
                    "GitSignsCurrentLineBlame"
                }, {'  ', "GitSignsCurrentLineBlameAccent"},
                {blame_info.summary .. ' ', "GitSignsCurrentLineBlame"}
            }
        end,
        current_line_blame_formatter_nc = '',
        numhl = true
    }

    local theme = require('common-theme')
    theme.set_hl("GitSignsAdd", {fg = theme.blender.add, bold = true})
    theme.set_hl("GitSignsChange", {fg = theme.blender.change, bold = true})
    theme.set_hl("GitSignsDelete", {fg = theme.blender.delete, bold = true})

    theme.set_hl('GitSignsCurrentLineBlame', {link = 'Comment'})
    theme.set_hl('GitSignsCurrentLineBlameAccent', {fg = 4, italic = true})
end

return M
