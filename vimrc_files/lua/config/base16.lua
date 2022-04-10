local M = {}

function M.setup()
    local base16 = require("base16-colorscheme")

    -- ref: https://github.com/RRethy/nvim-base16/blob/master/colors/base16-tomorrow-night.vim
    base16.setup({
        base00 = '#1d1f21',
        base01 = '#282a2e',
        base02 = '#373b41',
        base03 = '#969896',
        base04 = '#b4b7b4',
        base05 = '#c5c8c6',
        base06 = '#e0e0e0',
        base07 = '#ffffff',
        base08 = '#cc6666',
        base09 = '#de935f',
        base0A = '#f0c674',
        base0B = '#b5bd68',
        base0C = '#8abeb7',
        base0D = '#81a2be',
        base0E = '#b294bb',
        base0F = '#a3685a'
    })

    -- extended colors
    -- base color with the lightness percentage adjusted
    -- tool: https://www.w3schools.com/colors/colors_picker.asp
    base16.colors.base0D_20 = "#233443"
    base16.colors.base0D_40 = "#456887"
    base16.colors.base0A_20 = "#5c410a"
    base16.colors.base0A_40 = "#b98213"
    base16.colors.base09_40 = "#a95b23"

    vim.highlight.create("Cursor",
                         {gui = "inverse", guifg = "none", guibg = "none"},
                         false)
    vim.highlight.create("NonText",
                         {guifg = base16.colors.base02, guibg = "none"}, false)
    vim.highlight.create("Comment", {
        gui = "italic",
        guifg = base16.colors.base03,
        guibg = "none"
    }, false)
    vim.highlight.create("MatchParen",
                         {gui = "bold,italic", guifg = "none", guibg = "none"},
                         false)
    vim.highlight.create("VertSplit",
                         {guifg = base16.colors.base02, guibg = "none"}, false)
    vim.highlight.create("DiffAdd", {guifg = "none", guibg = "none"}, false)
    vim.highlight.create("DiffDelete", {
        guifg = base16.colorschemes["schemer-dark"].base00,
        guibg = base16.colorschemes["schemer-dark"].base00
    }, false)
    vim.highlight.create("DiffText", {
        guifg = "none",
        guibg = base16.colorschemes["schemer-medium"].base01
    }, false)
    vim.highlight.create("DiffChange", {guifg = "none", guibg = "bg"}, false)
    vim.highlight.create("Search", {
        guifg = base16.colors.base00,
        guibg = base16.colors.base0A_40
    }, false)
    vim.highlight.create("IncSearch", {
        guifg = base16.colors.base05,
        guibg = base16.colors.base09_40
    }, false)

    -- Completion
    vim.o.pumblend = 1
    vim.highlight.create("Pmenu", {
        guifg = base16.colors.base03,
        guibg = base16.colors.base01,
        blend = 15
    }, false)
    vim.highlight.create("PmenuSel", {
        guifg = "none",
        guibg = base16.colors.base0A_20,
        blend = 0
    }, false)
    vim.highlight.create("PmenuSbar", {guibg = base16.colors.base0D_20}, false)
    vim.highlight.create("PmenuThumb", {guibg = base16.colors.base0D_40}, false)

    -- Float
    vim.o.winblend = 1
    vim.highlight.create("NormalFloat", {
        guifg = base16.colors.base05,
        guibg = base16.colors.base01,
        blend = 15
    }, false)
    vim.highlight.create("FloatBorder", {
        guifg = base16.colors.base0D_40,
        guibg = base16.colors.base01,
        blend = 15
    }, false)
    vim.highlight.create("FloatTitle", {
        gui = "bold",
        guifg = base16.colors.base04,
        guibg = base16.colors.base01,
        blend = 15
    }, false)

    -- LSP Diagnostics
    vim.highlight.create("DiagnosticError", {guifg = base16.colors.base08},
                         false)
    vim.highlight.create("DiagnosticUnderlineError",
                         {gui = "undercurl", guisp = base16.colors.base08},
                         false)
    vim.highlight
        .create("DiagnosticWarn", {guifg = base16.colors.base0A}, false)
    vim.highlight.create("DiagnosticUnderlineWarn",
                         {gui = "undercurl", guisp = base16.colors.base0A},
                         false)
    vim.highlight
        .create("DiagnosticInfo", {guifg = base16.colors.base0B}, false)
    vim.highlight.create("DiagnosticUnderlineInfo",
                         {gui = "undercurl", guisp = base16.colors.base0B},
                         false)
    vim.highlight
        .create("DiagnosticHint", {guifg = base16.colors.base0D}, false)
    vim.highlight.create("DiagnosticUnderlineHint",
                         {gui = "undercurl", guisp = base16.colors.base0D},
                         false)
    vim.highlight.create("DiagnosticVirtualText", {
        gui = "undercurl,bold",
        guifg = base16.colors.base02,
        guibg = "none"
    }, false)
    vim.highlight.link("DiagnosticVirtualTextError", "DiagnosticVirtualText",
                       false)
    vim.highlight.link("DiagnosticVirtualTextWarn", "DiagnosticVirtualText",
                       false)
    vim.highlight.link("DiagnosticVirtualTextInfo", "DiagnosticVirtualText",
                       false)
    vim.highlight.link("DiagnosticVirtualTextHint", "DiagnosticVirtualText",
                       false)

    -- Gutter
    vim.highlight.create("LineNr", {guibg = "none"}, false)
    vim.highlight.create("CursorLineNr", {guibg = "none"}, false)
    vim.highlight.create("SignColumn", {guibg = "none"}, false)
    vim.highlight.create("FoldColumn",
                         {guifg = base16.colors.base02, guibg = "none"}, false)
    vim.highlight.create("Folded", {
        gui = "bold",
        guifg = base16.colors.base0A_40,
        guibg = base16.colors.base01
    }, false)
end

return M
