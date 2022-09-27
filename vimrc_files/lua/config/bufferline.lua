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
            fill = {fg = "none", bg = bgcolor},
            buffer_visible = {
                fg = base16.colors.base03,
                bg = base16.colors.base00
            },
            buffer_selected = {fg = base16.colors.base05, bold = true},
            background = {fg = base16.colors.base03, bg = bgcolor},
            separator_selected = {fg = bgcolor, bg = base16.colors.base00},
            separator_visible = {fg = bgcolor, bg = base16.colors.base00},
            separator = {fg = bgcolor, bg = bgcolor}
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
    vim.api.nvim_set_keymap("n", "<leader>bh", "<cmd>BufferLineCloseLeft<cr>",
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap("n", "<leader>bl", "<cmd>BufferLineCloseRight<cr>",
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap("n", "<leader>bo",
                            "<cmd>BufferLineCloseRight<cr><cmd>BufferLineCloseLeft<cr>",
                            {silent = true, noremap = true})
end

return M
