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
        lsp = {actions = {["default"] = actions.file_edit_or_qf}},
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
    vim.api.nvim_set_keymap("n", "<c-w><c-b>", "<cmd>FzfLua buffers<cr>",
                            {silent = true})
    vim.keymap.set('n', '<c-w><c-d>', function()
        vim.ui.select({'breakpoints', 'variables'}, {prompt = 'DAP Menu'},
                      function(choice) vim.cmd('FzfLua dap_' .. choice) end)
    end, {silent = true})
    vim.api.nvim_set_keymap("n", "<c-w><c-/>", ":FzfLua resume<cr>",
                            {silent = true})
    vim.api.nvim_set_keymap("n", "<c-/>", ":FzfLuaSearch<cr>", {silent = true})
    vim.api.nvim_set_keymap("x", "<c-/>", ":<c-u>FzfLua grep_visual<cr>",
                            {silent = true})
    vim.keymap.set('n', '<c-w><c-h>', function()
        vim.ui.select({'help_tags', 'man_pages'}, {prompt = 'Help Menu'},
                      function(choice) vim.cmd('FzfLua ' .. choice) end)
    end, {silent = true})

    local theme = require("common-theme")
    theme.set_hl("FzfLuaFloat", {link = "NormalFloat"})
    theme.set_hl("FzfLuaFloatBorder", {link = "FloatBorder"})
    theme.set_hl("FzfLuaCursor", {link = "PmenuSel"})
end

return M
