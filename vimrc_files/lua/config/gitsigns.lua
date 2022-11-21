local M = {}

function M.setup()
    require('gitsigns').setup {
        signs = {
            add = {hl = 'GitSignsAdd', text = ''},
            change = {hl = 'GitSignsChange', text = ''},
            delete = {hl = 'GitSignsDelete', text = ''},
            topdelete = {hl = 'GitSignsDelete', text = ''},
            changedelete = {hl = 'GitSignsChange', text = ''}
        },
        keymaps = {
            buffer = false,
            ['n <leader>gn'] = '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>',
            ['n <leader>gp'] = '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>',
            ['n <leader>gr'] = '<cmd>lua require\"gitsigns.actions\".reset_hunk()<CR>',
            ['n <leader>d'] = '<cmd>Gitsigns diffthis<CR>'
        },
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
