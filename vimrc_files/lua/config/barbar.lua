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

    local utils = require('common-utils')
    utils.noremap("n", "<c-,>", "<cmd>BufferMovePrevious<cr>")
    utils.noremap("n", "<c-.>", "<cmd>BufferMoveNext<cr>")
    utils.noremap("n", "<c-p>", "<cmd>BufferPrevious<cr>")
    utils.noremap("n", "<c-n>", "<cmd>BufferNext<cr>")
    utils.noremap("n", "gp", "<cmd>BufferPin<cr>")
    utils.noremap("n", "<leader>bh", "<cmd>confirm BufferCloseBuffersLeft<cr>")
    utils.noremap("n", "<leader>bl", "<cmd>confirm BufferCloseBuffersRight<cr>")
    utils.noremap("n", "<leader>ba", "<cmd>confirm BufferCloseAllButPinned<cr>")
    utils.noremap("n", "<leader>bo",
                  "<cmd>confirm BufferCloseAllButCurrentOrPinned<cr>")
    utils.noremap("n", "<c-q>", "<cmd>confirm BufferClose<cr>")
    utils.noremap("n", "g0", "<cmd>BufferGoto 1<cr>")
    utils.noremap("n", "g1", "<cmd>BufferGoto 2<cr>")
    utils.noremap("n", "g2", "<cmd>BufferGoto 3<cr>")
    utils.noremap("n", "g3", "<cmd>BufferGoto 4<cr>")
    utils.noremap("n", "g4", "<cmd>BufferGoto 5<cr>")
    utils.noremap("n", "g5", "<cmd>BufferGoto 6<cr>")
    utils.noremap("n", "g6", "<cmd>BufferGoto 7<cr>")
    utils.noremap("n", "g7", "<cmd>BufferGoto 8<cr>")
    utils.noremap("n", "g8", "<cmd>BufferGoto 9<cr>")
    utils.noremap("n", "g9", "<cmd>BufferGoto 10<cr>")
    utils.noremap("n", "g$", "<cmd>BufferLast<cr>")

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
    theme.set_hl('BufferInactiveMod', {
        fg = theme.blender.fg_darker_3,
        bg = theme.blender.bg_darker_2
    })
    theme.set_hl('BufferInactiveSign', {link = 'BufferInactive'})

    theme.set_hl('BufferTabpages', {bg = 4})
    theme.set_hl('BufferTabpageFill', {bg = theme.blender.bg_darker_2})
end

return M
