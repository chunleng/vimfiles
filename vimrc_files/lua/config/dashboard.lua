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
    local theme = require('common-theme')
    theme.set_hl("DashboardHeader", {fg = 4})
    theme.set_hl("DashboardCenter", {fg = 4})
    vim.api.nvim_buf_set_keymap(0, "n", "<c-space>", "<cmd>NvimTreeOpen<cr>",
                                {silent = true, noremap = true})
    local group_name = "Dashboard"
    vim.api.nvim_create_augroup(group_name, {clear = true})
    vim.api.nvim_create_autocmd("User", {
        pattern = "DashboardReady",
        callback = function()
            -- Restore overwritten fzf filesearch
            vim.api.nvim_buf_set_keymap(0, "n", "<enter>",
                                        "<cmd>FzfLua files<cr>",
                                        {silent = true, noremap = true})
            vim.api.nvim_buf_set_keymap(0, "n", "l",
                                        "<cmd>lua require(\"dashboard\").call_line_action()<cr>",
                                        {silent = true, noremap = true})

        end,
        group = group_name
    })
end

return M
