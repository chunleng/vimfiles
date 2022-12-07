local M = {}

function M.setup()
    local actions = require('fzf-lua.actions')
    require('fzf-lua').setup({
        keymap = {
            builtin = {
                ["<c-/>"] = "toggle-preview",
                ["<s-down>"] = "preview-page-down",
                ["<s-up>"] = "preview-page-up",
                ["<tab>"] = "toggle+down",
                ["<s-tab>"] = "toggle+up"
            },
            fzf = {["enter"] = "select+accept"}
        },
        actions = {files = {["default"] = actions.file_edit}},
        dap = {
            variables = {
                actions = {
                    ["default"] = function(selected)
                        -- TODO Add to watch after the following issue is resolved
                        -- https://github.com/rcarriga/nvim-dap-ui/issues/160
                        -- local expr = string.match(selected[0], '%] (.*) = ')
                        print(selected)
                    end
                }
            }
        },
        grep = {actions = {["default"] = actions.file_edit_or_qf}},
        winopts = {hl = {normal = "FzfLuaFloat", border = "FzfLuaFloatBorder"}},
        fzf_colors = {
            ["bg"] = {"bg", "FzfLuaFloat"},
            ["bg+"] = {"bg", "FzfLuaCursor"},
            ["gutter"] = {"bg", "FzfLuaFloat"}
        },
        fzf_args = "--select-1", -- auto-select when there is only one result
        file_icon_padding = " "
    })
    function _G.fzf_lua_search()
        vim.ui.input({prompt = "Search"}, function(response)
            if response == nil then return end
            require("fzf-lua.providers.grep").grep({search = response})
        end)
    end
    vim.cmd [[command! FzfLuaSearch call v:lua.fzf_lua_search()]]
    vim.api
        .nvim_set_keymap("n", "<enter>", ":FzfLua files<cr>", {silent = true})
    vim.api.nvim_set_keymap("n", "<leader>B", "<cmd>FzfLua buffers<cr>",
                            {silent = true})
    vim.api.nvim_set_keymap("n", "<leader>Db",
                            "<cmd>FzfLua dap_breakpoints<cr>", {silent = true})
    vim.api.nvim_set_keymap("n", "<leader>Dv", "<cmd>FzfLua dap_variables<cr>",
                            {silent = true})
    vim.api.nvim_set_keymap("n", "<leader>/", ":FzfLua resume<cr>",
                            {silent = true})
    vim.api.nvim_set_keymap("n", "<c-/>", ":FzfLuaSearch<cr>", {silent = true})
    vim.api.nvim_set_keymap("n", "<leader>?v", ":FzfLua help_tags<cr>",
                            {silent = true})
    vim.api.nvim_set_keymap("n", "<leader>?m", ":FzfLua man_pages<cr>",
                            {silent = true})
    vim.api.nvim_set_keymap("n", "<leader>g/", ":<c-u>FzfLua git_status<cr>",
                            {silent = true})
    vim.api.nvim_set_keymap("x", "<c-/>", ":<c-u>FzfLua grep_visual<cr>",
                            {silent = true})

    local theme = require("common-theme")
    theme.set_hl("FzfLuaFloat", {link = "NormalFloat"})
    theme.set_hl("FzfLuaFloatBorder", {link = "FloatBorder"})
    theme.set_hl("FzfLuaCursor", {link = "PmenuSel"})
end

return M
