local M = {}

local bufdelete = require('bufdelete')
local bufferline = require('bufferline')

local function close_buffer(bufnr)
    bufnr = bufnr and bufnr or vim.api.nvim_get_current_buf()
    if not require('bufferline.groups').is_pinned({id = bufnr}) then
        bufdelete.bufdelete(bufnr, false)
    end
end

function M.setup()
    bufferline.setup({
        options = {
            close_command = close_buffer,
            modified_icon = '⊙',
            show_buffer_icons = false,
            show_close_icon = false,
            show_buffer_default_icon = false,
            show_buffer_close_icons = false,
            always_show_bufferline = true,
            separator_style = {'', ''},
            indicator = {style = 'none'},
            left_trunc_marker = '',
            right_trunc_marker = ''

        }
    })
    local utils = require('common-utils')
    utils.noremap("n", "<c-p>", "<cmd>BufferLineCyclePrev<cr>")
    utils.noremap("n", "<c-n>", "<cmd>BufferLineCycleNext<cr>")
    utils.noremap("n", "<c-,>", "<cmd>BufferLineMovePrev<cr>")
    utils.noremap("n", "<c-.>", "<cmd>BufferLineMoveNext<cr>")
    utils.noremap("n", "gp", "<cmd>BufferLineTogglePin<cr>")
    utils.noremap("n", "<leader>bh", "<cmd>confirm BufferLineCloseLeft<cr>")
    utils.noremap("n", "<leader>bl", "<cmd>confirm BufferLineCloseRight<cr>")
    utils.noremap("n", "<c-q>", close_buffer)
    utils.noremap("n", "<leader>ba", function()
        for _, element in ipairs(require('bufferline').get_elements().elements) do
            close_buffer(element.id)
        end
    end)
    utils.noremap("n", "<leader>bo", function()
        for _, element in ipairs(require('bufferline').get_elements().elements) do
            if element.id ~= vim.api.nvim_get_current_buf() then
                close_buffer(element.id)
            end
        end
    end)
    utils.noremap("n", "g0", "<cmd>BufferLineGoToBuffer 1<cr>")
    utils.noremap("n", "g1", "<cmd>BufferLineGoToBuffer 2<cr>")
    utils.noremap("n", "g2", "<cmd>BufferLineGoToBuffer 3<cr>")
    utils.noremap("n", "g3", "<cmd>BufferLineGoToBuffer 4<cr>")
    utils.noremap("n", "g4", "<cmd>BufferLineGoToBuffer 5<cr>")
    utils.noremap("n", "g5", "<cmd>BufferLineGoToBuffer 6<cr>")
    utils.noremap("n", "g6", "<cmd>BufferLineGoToBuffer 7<cr>")
    utils.noremap("n", "g7", "<cmd>BufferLineGoToBuffer 8<cr>")
    utils.noremap("n", "g8", "<cmd>BufferLineGoToBuffer 9<cr>")
    utils.noremap("n", "g9", "<cmd>BufferLineGoToBuffer 10<cr>")
    utils.noremap("n", "g$", "<cmd>BufferLineGoToBuffer -1<cr>")

    local theme = require('common-theme')
    local bgcolor = theme.blender.bg_darker_2
    theme.set_hl('BufferLineFill', {bg = bgcolor})
    theme.set_hl('BufferLineBackground',
                 {fg = theme.blender.fg_darker_2, bg = bgcolor})
    theme.set_hl('BufferLineBufferVisible', {bg = bgcolor, bold = true})
    theme.set_hl('BufferLineBufferSelected', {bold = true})
    theme.set_hl('BufferLineModified', {fg = 2, bg = bgcolor})
    theme.set_hl('BufferLineModifiedVisible', {fg = 2, bg = bgcolor})
    theme.set_hl('BufferLineModifiedSelected', {fg = 2})
    theme.set_hl('BufferLineIndicatorVisible', {bg = bgcolor})

    theme.set_hl('BufferLineTab',
                 {fg = theme.blender.bg_lighter_3, bg = bgcolor})
    theme.set_hl('BufferLineTabSelected', {fg = 14, bg = bgcolor, bold = true})
    theme.set_hl('BufferLineTabSeparator', {fg = bgcolor, bg = bgcolor})
    theme.set_hl('BufferLineTabSeparatorSelected', {fg = bgcolor, bg = bgcolor})

end

return M
