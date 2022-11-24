local M = {}

function M.setup()
    require("bufferline").setup({
        animation = false,
        icon_pinned = '',
        icon_separator_active = '',
        icon_separator_inactive = '',
        icon_close_tab = '',
        icon_close_tab_modified = '⊙',
        minimum_padding = 2,
        maximum_padding = 2,
        maximum_length = 40,
        exclude_ft = {'qf', 'dap-repl'}
    })

    vim.api.nvim_set_keymap("n", "<c-,>", "<cmd>BufferMovePrevious<cr>",
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap("n", "<c-.>", "<cmd>BufferMoveNext<cr>",
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap("n", "<c-p>", "<cmd>BufferPrevious<cr>",
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap("n", "<c-n>", "<cmd>BufferNext<cr>",
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap("n", "gp", "<cmd>BufferPin<cr>",
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap("n", "<leader>bh",
                            "<cmd>confirm BufferCloseBuffersLeft<cr>",
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap("n", "<leader>bl",
                            "<cmd>confirm BufferCloseBuffersRight<cr>",
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap("n", "<leader>ba",
                            "<cmd>confirm BufferCloseAllButPinned<cr>",
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap("n", "<leader>bo",
                            "<cmd>confirm BufferCloseAllButCurrentOrPinned<cr>",
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap("n", "<c-x>", "<cmd>confirm BufferClose<cr>",
                            {noremap = true, silent = true})
    vim.api.nvim_set_keymap("n", "<c-x>", "<cmd>confirm BufferClose<cr>",
                            {noremap = true, silent = true})
    vim.api.nvim_set_keymap("n", "g0", "<cmd>BufferGoto 1<cr>",
                            {noremap = true, silent = true})
    vim.api.nvim_set_keymap("n", "g$", "<cmd>BufferLast<cr>",
                            {noremap = true, silent = true})

    local theme = require('common-theme')

    theme.set_hl('BufferCurrent', {})
    theme.set_hl('BufferCurrentMod', {fg = 2})
    theme.set_hl('BufferCurrentSign', {link = 'BufferCurrent'})

    theme.set_hl('BufferVisible', {bg = theme.blender.bg_darker_2})
    theme.set_hl('BufferVisibleMod', {fg = 2, bg = theme.blender.bg_darker_2})
    theme.set_hl('BufferVisibleSign', {link = 'BufferVisible'})

    theme.set_hl('BufferInactive', {
        fg = theme.blender.fg_darker_3,
        bg = theme.blender.bg_darker_2
    })
    theme.set_hl('BufferInactiveMod',
                 {bg = theme.blender.bg_darker_2, nocombine = true})
    theme.set_hl('BufferInactiveSign', {link = 'BufferInactive'})

    theme.set_hl('BufferTabpages', {bg = 4})
    theme.set_hl('BufferTabpageFill', {bg = theme.blender.bg_darker_2})
end

return M
