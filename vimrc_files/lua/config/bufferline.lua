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
            numbers = function(opt) return opt.ordinal - 1 end,
            modified_icon = '⊙',
            show_buffer_icons = false,
            show_close_icon = false,
            show_buffer_default_icon = false,
            show_buffer_close_icons = false,
            always_show_bufferline = true,
            separator_style = {'', ''},
            indicator = {style = 'none'},
            left_trunc_marker = '',
            right_trunc_marker = '',
            custom_filter = function(bufnr)
                if vim.tbl_contains({'dap-repl', 'neotest-summary'},
                                    vim.bo[bufnr].filetype) then
                    return false
                end
                return true
            end
        }
    })
    local utils = require('common-utils')
    utils.keymap({'n', 'x'}, "<c-p>", "<cmd>BufferLineCyclePrev<cr>")
    utils.keymap({'n', 'x'}, "<c-n>", "<cmd>BufferLineCycleNext<cr>")
    utils.keymap({'n', 'x'}, "<c-s-[>", "<cmd>BufferLineMovePrev<cr>",
                 {silent = false})
    utils.keymap({'n', 'x'}, "<c-s-]>", "<cmd>BufferLineMoveNext<cr>",
                 {silent = false})
    utils.keymap({'n', 'x'}, "gp", "<cmd>BufferLineTogglePin<cr>")
    utils.keymap({'n', 'x'}, "<leader>bh",
                 "<cmd>confirm BufferLineCloseLeft<cr>")
    utils.keymap({'n', 'x'}, "<leader>bl",
                 "<cmd>confirm BufferLineCloseRight<cr>")
    utils.keymap({'n', 'x'}, "<c-q>", close_buffer)
    utils.keymap({'n', 'x'}, "<leader>ba", function()
        for _, element in ipairs(require('bufferline').get_elements().elements) do
            close_buffer(element.id)
        end
    end)
    utils.keymap({'n', 'x'}, "<leader>bo", function()
        for _, element in ipairs(require('bufferline').get_elements().elements) do
            if element.id ~= vim.api.nvim_get_current_buf() then
                close_buffer(element.id)
            end
        end
    end)
    utils.keymap({'n', 'x'}, "g0", "<cmd>BufferLineGoToBuffer 1<cr>")
    utils.keymap({'n', 'x'}, "g1", "<cmd>BufferLineGoToBuffer 2<cr>")
    utils.keymap({'n', 'x'}, "g2", "<cmd>BufferLineGoToBuffer 3<cr>")
    utils.keymap({'n', 'x'}, "g3", "<cmd>BufferLineGoToBuffer 4<cr>")
    utils.keymap({'n', 'x'}, "g4", "<cmd>BufferLineGoToBuffer 5<cr>")
    utils.keymap({'n', 'x'}, "g5", "<cmd>BufferLineGoToBuffer 6<cr>")
    utils.keymap({'n', 'x'}, "g6", "<cmd>BufferLineGoToBuffer 7<cr>")
    utils.keymap({'n', 'x'}, "g7", "<cmd>BufferLineGoToBuffer 8<cr>")
    utils.keymap({'n', 'x'}, "g8", "<cmd>BufferLineGoToBuffer 9<cr>")
    utils.keymap({'n', 'x'}, "g9", "<cmd>BufferLineGoToBuffer 10<cr>")
    utils.keymap({'n', 'x'}, "g$", "<cmd>BufferLineGoToBuffer -1<cr>")

    local theme = require('common-theme')
    local bgcolor = theme.blender.bg_darker_2
    theme.set_hl('BufferLineFill', {bg = bgcolor})
    theme.set_hl('BufferLineBackground',
                 {fg = theme.blender.fg_darker_2, bg = bgcolor})
    theme.set_hl('BufferLineBufferVisible', {bg = bgcolor, bold = true})
    theme.set_hl('BufferLineBufferSelected', {bold = true})
    theme.set_hl('BufferLineNumbers',
                 {fg = theme.blender.fg_darker_2, bg = bgcolor})
    theme.set_hl('BufferLineNumbersVisible',
                 {fg = theme.blender.bg_lighter_1, bg = bgcolor})
    theme.set_hl('BufferLineNumbersSelected', {fg = theme.blender.bg_lighter_2})
    theme.set_hl('BufferLineDuplicate',
                 {fg = theme.blender.bg_lighter_3, bg = bgcolor})
    theme.set_hl('BufferLineDuplicateVisible',
                 {fg = theme.blender.bg_lighter_3, bg = bgcolor, bold = true})
    theme.set_hl('BufferLineDuplicateSelected',
                 {fg = theme.blender.bg_lighter_3, bold = true})
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
