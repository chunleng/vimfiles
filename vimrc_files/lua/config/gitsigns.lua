local M = {}

function M.setup()
    require('gitsigns').setup {
        signs = {
            add = {
                hl = 'GitSignsAdd',
                text = '│',
                numhl = 'GitSignsAddNr',
                linehl = 'GitSignsAddLn'
            },
            change = {
                hl = 'GitSignsChange',
                text = '│',
                numhl = 'GitSignsChangeNr',
                linehl = 'GitSignsChangeLn'
            },
            delete = {
                hl = 'GitSignsDelete',
                text = '│',
                numhl = 'GitSignsDeleteNr',
                linehl = 'GitSignsDeleteLn'
            },
            topdelete = {
                hl = 'GitSignsDelete',
                text = '│',
                numhl = 'GitSignsDeleteNr',
                linehl = 'GitSignsDeleteLn'
            },
            changedelete = {
                hl = 'GitSignsChange',
                text = '│',
                numhl = 'GitSignsChangeNr',
                linehl = 'GitSignsChangeLn'
            }
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

    local base16 = require("base16-colorscheme")
    vim.highlight.create("GitSignsAdd", {
        guifg = base16.colors.base0B,
        guibg = base16.colors.base01
    }, false)
    vim.highlight.create("GitSignsAddLn", {
        guibg = base16.colorschemes["schemer-medium"].base00
    }, false)
    vim.highlight.create("GitSignsChange", {
        guifg = base16.colors.base0D,
        guibg = base16.colors.base01
    }, false)
    vim.highlight.create("GitSignsChangeLn", {
        guibg = base16.colorschemes["schemer-medium"].base00
    }, false)
    vim.highlight.create("GitSignsDelete", {
        guifg = base16.colors.base0F,
        guibg = base16.colors.base01
    }, false)
    vim.highlight.create("GitSignsDeleteLn", {guibg = "bg"}, false)

    vim.highlight.create("GitSignsCurrentLineBlame", {
        gui = "none",
        guifg = base16.colors.base04,
        guibg = base16.colors.base01
    }, false)
    vim.highlight
        .create("GitSignsCurrentLineBlameNoBg", {guibg = "none"}, false)
    vim.highlight.create("GitSignsCurrentLineBlameAccent", {
        gui = "none",
        guifg = base16.colors.base09_40,
        guibg = base16.colors.base01
    }, false)
end

return M
