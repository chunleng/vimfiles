local M = {}

function M.setup()
    local neotest = require('neotest')
    neotest.setup({
        adapters = {},
        icons = {
            child_indent = ' ',
            child_prefix = ' ',
            collapsed = '▸',
            expanded = '▾',
            final_child_indent = ' ',
            final_child_prefix = ' ',
            non_collapsible = ' ',
            failed = '',
            passed = '',
            unknown = '',
            skipped = '',
            running = ''
        },
        output_panel = {open = 'topleft vsplit | vertical resize 20'},
        quickfix = {enabled = false},
        summary = {
            animated = false,
            open = 'topleft vsplit | vertical resize 30',
            mappings = {
                attach = {},
                clear_marked = {},
                clear_target = {},
                debug = 'd',
                debug_marked = {},
                expand = 'l',
                expand_all = {},
                jumpto = '<cr>',
                mark = {},
                next_failed = "J",
                output = {},
                prev_failed = "K",
                run = "r",
                run_marked = {},
                short = 'o',
                stop = {},
                target = {}
            }
        }
    })

    local utils = require('common-utils')
    utils.keymap('n', '<c-s-t>', function() neotest.summary.toggle() end)
    utils.keymap('n', '<c-t>', function() neotest.run.run() end)
    utils.keymap('n', '<leader>ct',
                 function() neotest.run.run(vim.fn.expand('%')) end)

    local group_name = 'lNeotestSummary'
    vim.api.nvim_create_augroup(group_name, {clear = true})
    vim.api.nvim_create_autocmd('FileType', {
        pattern = 'neotest-summary',
        callback = function(opt)
            utils.buf_keymap(opt.buf, 'n', 'q',
                             function() neotest.summary.close() end)
        end,
        group = group_name
    })

    local theme = require('common-theme')
    theme.set_hl('NeotestAdapterName', {bold = true, fg = 4})
    theme.set_hl('NeotestExpandMarker', {link = 'Comment'})
    theme.set_hl('NeotestDir', {fg = theme.blender.fg_darker_3})
    theme.set_hl('NeotestFile', {fg = 12})
    theme.set_hl('NeotestFocused', {underline = true})
    theme.set_hl('NeotestPassed', {fg = theme.blender.passed})
    theme.set_hl('NeotestFailed', {fg = theme.blender.failed})
    theme.set_hl('NeotestUnknown', {fg = theme.blender.bg_lighter_3})
    theme.set_hl('NeotestSkipped', {fg = 14})
    theme.set_hl('NeotestRunning', {fg = 12})
    theme.set_hl('NeotestTest', {link = 'Normal'})
end

return M
