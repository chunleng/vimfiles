local M = {}

function M.setup()
    local db = require('dashboard')
    db.custom_center = {
        {
            icon = " ",
            desc = "New File                     ",
            action = "bd" -- Deleting the dashboard buffer brings to the new file
        }, {
            icon = " ",
            desc = "Bookmarks                    ",
            action = "FzfLua marks"
        }, {
            icon = " ",
            desc = "Find File          CTRL SPACE",
            action = "FzfLua files" -- link to fzf.vim config
        }, {
            icon = " ",
            desc = "Find Word          CTRL /    ",
            action = "FzfLuaSearch" -- link to fzf.vim config
        }
    }
    db.custom_footer = nil
    local base16 = require("base16-colorscheme")
    vim.api.nvim_set_hl(0, "DashboardHeader", {fg = base16.colors.base0D_40})
    vim.api.nvim_set_hl(0, "DashboardCenter", {fg = base16.colors.base0D})
    vim.cmd [[
        augroup Dashboard
            autocmd!
            autocmd FileType dashboard nnoremap <buffer><silent><leader><space> :NvimTreeOpen<cr>
        augroup END
    ]]
end

return M
