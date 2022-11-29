local M = {}

function M.setup()
    local kind_icons = require("common-utils").kind_icons
    local js_kind = {
        "Class", "Constructor", "Enum", "Function", "Interface", "Module",
        "Method", "Struct", "Constant", "Variable", "Field"
    }
    local data_kind = {"Module", "Number", "Array", "Boolean", "String"}

    require("aerial").setup({
        attach_mode = "global",
        backends = {'lsp', 'treesitter', 'markdown', 'man'}, -- LSP is still more stable, prioritize LSP first
        show_guide = true,
        layout = {
            placement = "edge",
            min_width = 30,
            max_width = 30,
            default_direction = 'right'
        },
        icons = kind_icons,
        filter_kind = {
            ['_'] = {
                "Class", "Constructor", "Enum", "Function", "Interface",
                "Module", "Method", "Struct"
            },
            typescriptreact = js_kind,
            javascriptreact = js_kind,
            typescript = js_kind,
            javascript = js_kind,
            json = data_kind,
            yaml = data_kind
        },
        on_attach = function(bufnr)
            if os.getenv("NOAERIAL") ~= '1' and M.opened ~= 1 then
                require('aerial').open({focus = false})
                M.opened = 1
            end
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cc',
                                        '<cmd>AerialToggle!<cr>',
                                        {silent = true, noremap = true})
        end
    })

    local theme = require('common-theme')
    theme.set_hl('AerialLine', {fg = 0, bg = 6})
    theme.set_hl('AerialLineNC', {
        fg = theme.blender.fg_darker_3,
        bg = theme.blender.bg_lighter_2
    })

    local group_name = "Aerial"
    vim.api.nvim_create_augroup(group_name, {clear = true})
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "aerial",
        callback = function()
            vim.keymap.del('n', '<c-j>', {buffer = true})
            vim.keymap.del('n', '<c-k>', {buffer = true})
            vim.keymap.set('n', 'J', '<cmd>AerialNext<cr>',
                           {buffer = true, silent = true, noremap = true})
            vim.keymap.set('n', 'K', '<cmd>AerialPrev<cr>',
                           {buffer = true, silent = true, noremap = true})
        end,
        group = group_name
    })
end

return M
