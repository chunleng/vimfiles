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
    vim.api.nvim_set_hl(0, "GitSignsAdd",
                        {fg = base16.colors.base0B, bg = base16.colors.base01})
    vim.api.nvim_set_hl(0, "GitSignsAddLn",
                        {bg = base16.colorschemes["schemer-medium"].base00})
    vim.api.nvim_set_hl(0, "GitSignsChange",
                        {fg = base16.colors.base0D, bg = base16.colors.base01})
    vim.api.nvim_set_hl(0, "GitSignsChangeLn",
                        {bg = base16.colorschemes["schemer-medium"].base00})
    vim.api.nvim_set_hl(0, "GitSignsDelete",
                        {fg = base16.colors.base0F, bg = base16.colors.base01})
    vim.api.nvim_set_hl(0, "GitSignsDeleteLn", {bg = "bg"})

    vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame",
                        {fg = base16.colors.base04, bg = base16.colors.base01})
    vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlameNoBg", {bg = "none"})
    vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlameAccent", {
        fg = base16.colors.base09_40,
        bg = base16.colors.base01
    })
end

return M
