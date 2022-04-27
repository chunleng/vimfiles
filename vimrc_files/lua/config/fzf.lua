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
        winopts = {
            hl = {
                normal = "FzfLuaFloat",
                border = "FzfLuaFloatBorder",
                cursorline = "FzfLuaFloatPreviewCursorLine"
            }
        },
        fzf_colors = {
            ["bg"] = {"bg", "FzfLuaFloat"},
            ["bg+"] = {"bg", "FzfLuaFloatCursorLine"},
            ["info"] = {"fg", "FzfLuaFloatInfo"},
            ["gutter"] = {"bg", "FzfLuaFloat"},
            ["prompt"] = {"fg", "FzfLuaFloatPrompt"},
            ["pointer"] = {"fg", "FzfLuaFloatPointer"},
            ["marker"] = {"fg", "FzfLuaFloatMarker"}
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
    vim.api.nvim_set_keymap("n", "<c-space>", ":FzfLua files<cr>",
                            {silent = true})
    vim.api.nvim_set_keymap("n", "<leader>/", ":FzfLua resume<cr>",
                            {silent = true})
    vim.api.nvim_set_keymap("n", "<c-/>", ":FzfLuaSearch<cr>", {silent = true})
    vim.api.nvim_set_keymap("n", "<f1>", ":FzfLua help_tags<cr>",
                            {silent = true})
    vim.api.nvim_set_keymap("v", "<c-/>", ":<c-u>FzfLua grep_visual<cr>",
                            {silent = true})

    local base16 = require("base16-colorscheme")
    vim.highlight.link("FzfLuaFloat", "NormalFloat", false)
    vim.highlight.link("FzfLuaFloatBorder", "FloatBorder", false)
    vim.highlight.link("FzfLuaFloatCursorLine", "PmenuSel", false)
    vim.highlight.create("FzfLuaFloatPreviewCursorLine", {gui = "none"}, false)
    vim.highlight.create("FzfLuaFloatInfo", {guifg = base16.colors.base0D_40},
                         false)
    vim.highlight.create("FzfLuaFloatPrompt", {guifg = base16.colors.base03},
                         false)
    vim.highlight.create("FzfLuaFloatPointer", {guifg = base16.colors.base03},
                         false)
    vim.highlight.create("FzfLuaFloatMarker", {guifg = base16.colors.base06},
                         false)
end

return M
