local M = {}

function M.setup()
    local kind_icons = require("common-utils").kind_icons
    local js_kind = {
        "Class", "Constructor", "Enum", "Function", "Interface", "Module",
        "Method", "Struct", "Constant", "Variable", "Field"
    }
    local data_kind = {"Module", "Number", "Array", "Boolean", "String"}

    require("aerial").setup({
        close_behavior = "global",
        backends = {"lsp", "treesitter", "markdown"}, -- LSP is still more stable, prioritize LSP first
        min_width = 30,
        max_width = 30,
        show_guide = true,
        placement_editor_edge = true,
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
        open_automatic = os.getenv("NOAERIAL") == nil and true or false,
        default_direction = "right",
        on_attach = function(bufnr)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cc',
                                        '<cmd>AerialToggle!<cr>',
                                        {silent = true, noremap = true})
        end
    })
    local base16 = require("base16-colorscheme")
    vim.api.nvim_set_hl(0, "AerialLine",
                        {bg = base16.colors.base0A_20, blend = 0})
end

return M
