local M = {}

function M.setup()
    local base16 = require("base16-colorscheme")
    local bgcolor = base16.colorschemes["schemer-dark"].base00
    require("bufferline").setup {
        options = {
            show_buffer_close_icons = false,
            show_close_icon = false,
            separator_style = "slant"
        },
        highlights = {
            fill = {guifg = "none", guibg = bgcolor},
            buffer_visible = {
                guifg = base16.colors.base03,
                guibg = base16.colors.base00
            },
            buffer_selected = {guifg = base16.colors.base05, gui = "bold"},
            background = {guifg = base16.colors.base03, guibg = bgcolor},
            separator_selected = {guifg = bgcolor, guibg = base16.colors.base00},
            separator_visible = {guifg = bgcolor, guibg = base16.colors.base00},
            separator = {guifg = bgcolor, guibg = bgcolor}
        }
    }
    vim.api.nvim_set_keymap("n", "<c-,>", "<cmd>BufferLineMovePrev<cr>",
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap("n", "<c-.>", "<cmd>BufferLineMoveNext<cr>",
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap("n", "<c-p>", "<cmd>BufferLineCyclePrev<cr>",
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap("n", "<c-n>", "<cmd>BufferLineCycleNext<cr>",
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap("n", "<tab>", "<cmd>b #<cr>",
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap("n", "<leader>bh", "<cmd>BufferLineCloseLeft<cr>",
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap("n", "<leader>bl", "<cmd>BufferLineCloseRight<cr>",
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap("n", "<leader>bo",
                            "<cmd>BufferLineCloseRight<cr><cmd>BufferLineCloseLeft<cr>",
                            {silent = true, noremap = true})
end

return M
