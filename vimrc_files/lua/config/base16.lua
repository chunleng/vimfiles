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
    base16.colors.base00_15 = "#242629" -- for barely visible shade
    base16.colors.base0D_20 = "#233443"
    base16.colors.base0D_40 = "#456887"
    base16.colors.base0A_20 = "#5c410a"
    base16.colors.base0A_40 = "#b98213"
    base16.colors.base09_40 = "#a95b23"

    vim.api.nvim_set_hl(0, "Cursor", {reverse = true, fg = "none", bg = "none"})
    vim.api.nvim_set_hl(0, "NonText", {fg = base16.colors.base02, bg = "none"})
    vim.api.nvim_set_hl(0, "Comment",
                        {italic = true, fg = base16.colors.base03, bg = "none"})
    vim.api.nvim_set_hl(0, "MatchParen",
                        {bold = true, italic = true, fg = "none", bg = "none"})
    vim.api
        .nvim_set_hl(0, "VertSplit", {fg = base16.colors.base02, bg = "none"})
    vim.api.nvim_set_hl(0, "DiffAdd", {fg = "none", bg = "none"})
    vim.api.nvim_set_hl(0, "DiffDelete", {
        fg = base16.colorschemes["schemer-dark"].base00,
        bg = base16.colorschemes["schemer-dark"].base00
    })
    vim.api.nvim_set_hl(0, "DiffText", {
        fg = "none",
        bg = base16.colorschemes["schemer-medium"].base01
    })
    vim.api.nvim_set_hl(0, "DiffChange", {fg = "none", bg = "bg"})
    vim.api.nvim_set_hl(0, "Search", {
        fg = base16.colors.base00,
        bg = base16.colors.base0A_40
    })
    vim.api.nvim_set_hl(0, "IncSearch", {
        fg = base16.colors.base05,
        bg = base16.colors.base09_40
    })

    -- Completion
    vim.o.pumblend = 1
    vim.api.nvim_set_hl(0, "Pmenu", {
        fg = base16.colors.base03,
        bg = base16.colors.base01,
        blend = 15
    })
    vim.api.nvim_set_hl(0, "PmenuSel",
                        {fg = "none", bg = base16.colors.base0A_20, blend = 0})
    vim.api.nvim_set_hl(0, "PmenuSbar", {bg = base16.colors.base0D_20})
    vim.api.nvim_set_hl(0, "PmenuThumb", {bg = base16.colors.base0D_40})

    -- Float
    vim.o.winblend = 1
    vim.api.nvim_set_hl(0, "NormalFloat", {
        fg = base16.colors.base05,
        bg = base16.colors.base01,
        blend = 15
    })
    vim.api.nvim_set_hl(0, "FloatBorder", {
        fg = base16.colors.base0D_40,
        bg = base16.colors.base01,
        blend = 15
    })
    vim.api.nvim_set_hl(0, "FloatTitle", {
        bold = true,
        fg = base16.colors.base04,
        bg = base16.colors.base01,
        blend = 15
    })

    -- LSP Diagnostics
    vim.api.nvim_set_hl(0, "DiagnosticError", {fg = base16.colors.base08})
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineError",
                        {undercurl = true, sp = base16.colors.base08})
    vim.api.nvim_set_hl(0, "DiagnosticWarn", {fg = base16.colors.base0A})
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn",
                        {undercurl = true, sp = base16.colors.base0A})
    vim.api.nvim_set_hl(0, "DiagnosticInfo", {fg = base16.colors.base0B})
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo",
                        {undercurl = true, sp = base16.colors.base0B})
    vim.api.nvim_set_hl(0, "DiagnosticHint", {fg = base16.colors.base0D})
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint",
                        {undercurl = true, sp = base16.colors.base0D})
    vim.api.nvim_set_hl(0, "DiagnosticVirtualText", {
        undercurl = true,
        bold = true,
        fg = base16.colors.base02,
        bg = "none"
    })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError",
                        {link = "DiagnosticVirtualText"})
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn",
                        {link = "DiagnosticVirtualText"})
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo",
                        {link = "DiagnosticVirtualText"})
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint",
                        {link = "DiagnosticVirtualText"})

    -- Gutter
    vim.api.nvim_set_hl(0, "LineNr", {bg = "none"})
    vim.api.nvim_set_hl(0, "CursorLineNr", {bg = "none"})
    vim.api.nvim_set_hl(0, "SignColumn", {bg = "none"})
    vim.api.nvim_set_hl(0, "FoldColumn",
                        {fg = base16.colors.base02, bg = "none"})
    vim.api.nvim_set_hl(0, "Folded", {
        bold = true,
        fg = base16.colors.base0A_40,
        bg = base16.colors.base01
    })
end

return M
