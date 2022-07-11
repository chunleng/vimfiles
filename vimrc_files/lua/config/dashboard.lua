local M = {}

function M.setup()
    vim.g.dashboard_custom_section = {
        a_file_new = {
            description = {" New File                     "},
            command = "bd" -- Deleting the dashboard buffer brings to the new file
        },
        b_bookmark = {
            description = {" Bookmarks                    "},
            command = "FzfLua marks"
        },
        c_find_file = {
            description = {" Find File          CTRL SPACE"},
            command = "FzfLua files" -- link to fzf.vim config
        },
        d_find_word = {
            description = {" Find Word          CTRL /    "},
            command = "FzfLuaSearch" -- link to fzf.vim config
        }
    }
    vim.g.dashboard_custom_footer = {}
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
