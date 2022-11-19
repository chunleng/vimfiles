local M = {}

function M.setup()
    require('gitsigns').setup {
        signs = {
            add = {hl = 'GitSignsAdd', text = '│'},
            change = {hl = 'GitSignsChange', text = '│'},
            delete = {hl = 'GitSignsDelete', text = '│'},
            topdelete = {hl = 'GitSignsDelete', text = '│'},
            changedelete = {hl = 'GitSignsChange', text = '│'}
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
            if blame_info.author == "Not Committed Yet" then
                return {
                    {'      ', 'GitSignsCurrentLineBlameBoldNoBg'},
                    {
                        '│ ' .. blame_info.author .. ' ',
                        'GitSignsCurrentLineBlame'
                    }
                }
            end

            local author = blame_info.author == name and "Me" or
                               blame_info.author
            return {
                {'      ', 'GitSignsCurrentLineBlameBoldNoBg'},
                {'│ ', 'GitSignsCurrentLineBlame'},
                {'  ', 'GitSignsCurrentLineBlameAccent'}, {
                    string.format("%s on %s", author,
                                  os.date("%Y/%m/%d", blame_info.author_time)),
                    "GitSignsCurrentLineBlame"
                }, {'  ', "GitSignsCurrentLineBlameAccent"},
                {blame_info.summary .. ' ', "GitSignsCurrentLineBlame"}
            }
        end,
        numhl = true
    }

    local theme = require('common-theme')
    theme.set_hl("GitSignsAdd",
                 {fg = theme.blender.add, bg = theme.blender.bg_lighter_1})
    theme.set_hl("GitSignsChange",
                 {fg = theme.blender.change, bg = theme.blender.bg_lighter_1})
    theme.set_hl("GitSignsDelete",
                 {fg = theme.blender.delete, bg = theme.blender.bg_lighter_1})

    theme.set_hl('GitSignsCurrentLineBlame', {
        fg = theme.blender.fg_darker_3,
        bg = theme.blender.bg_lighter_2
    })
    theme.set_hl('GitSignsCurrentLineBlameNoBg', {nocombine = true})
    theme.set_hl('GitSignsCurrentLineBlameAccent',
                 {fg = 2, bg = theme.blender.bg_lighter_2})
end

return M
