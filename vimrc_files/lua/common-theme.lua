local M = {}

M.colormap = {
    [16] = '#000000',
    [17] = '#00005f',
    [18] = '#000087',
    [19] = '#0000af',
    [20] = '#0000d7',
    [21] = '#0000ff',
    [22] = '#005f00',
    [23] = '#005f5f',
    [24] = '#005f87',
    [25] = '#005faf',
    [26] = '#005fd7',
    [27] = '#005fff',
    [28] = '#008700',
    [29] = '#00875f',
    [30] = '#008787',
    [31] = '#0087af',
    [32] = '#0087d7',
    [33] = '#0087ff',
    [34] = '#00af00',
    [35] = '#00af5f',
    [36] = '#00af87',
    [37] = '#00afaf',
    [38] = '#00afd7',
    [39] = '#00afff',
    [40] = '#00d700',
    [41] = '#00d75f',
    [42] = '#00d787',
    [43] = '#00d7af',
    [44] = '#00d7d7',
    [45] = '#00d7ff',
    [46] = '#00ff00',
    [47] = '#00ff5f',
    [48] = '#00ff87',
    [49] = '#00ffaf',
    [50] = '#00ffd7',
    [51] = '#00ffff',
    [52] = '#5f0000',
    [53] = '#5f005f',
    [54] = '#5f0087',
    [55] = '#5f00af',
    [56] = '#5f00d7',
    [57] = '#5f00ff',
    [58] = '#5f5f00',
    [59] = '#5f5f5f',
    [60] = '#5f5f87',
    [61] = '#5f5faf',
    [62] = '#5f5fd7',
    [63] = '#5f5fff',
    [64] = '#5f8700',
    [65] = '#5f875f',
    [66] = '#5f8787',
    [67] = '#5f87af',
    [68] = '#5f87d7',
    [69] = '#5f87ff',
    [70] = '#5faf00',
    [71] = '#5faf5f',
    [72] = '#5faf87',
    [73] = '#5fafaf',
    [74] = '#5fafd7',
    [75] = '#5fafff',
    [76] = '#5fd700',
    [77] = '#5fd75f',
    [78] = '#5fd787',
    [79] = '#5fd7af',
    [80] = '#5fd7d7',
    [81] = '#5fd7ff',
    [82] = '#5fff00',
    [83] = '#5fff5f',
    [84] = '#5fff87',
    [85] = '#5fffaf',
    [86] = '#5fffd7',
    [87] = '#5fffff',
    [88] = '#870000',
    [89] = '#87005f',
    [90] = '#870087',
    [91] = '#8700af',
    [92] = '#8700d7',
    [93] = '#8700ff',
    [94] = '#875f00',
    [95] = '#875f5f',
    [96] = '#875f87',
    [97] = '#875faf',
    [98] = '#875fd7',
    [99] = '#875fff',
    [100] = '#878700',
    [101] = '#87875f',
    [102] = '#878787',
    [103] = '#8787af',
    [104] = '#8787d7',
    [105] = '#8787ff',
    [106] = '#87af00',
    [107] = '#87af5f',
    [108] = '#87af87',
    [109] = '#87afaf',
    [110] = '#87afd7',
    [111] = '#87afff',
    [112] = '#87d700',
    [113] = '#87d75f',
    [114] = '#87d787',
    [115] = '#87d7af',
    [116] = '#87d7d7',
    [117] = '#87d7ff',
    [118] = '#87ff00',
    [119] = '#87ff5f',
    [120] = '#87ff87',
    [121] = '#87ffaf',
    [122] = '#87ffd7',
    [123] = '#87ffff',
    [124] = '#af0000',
    [125] = '#af005f',
    [126] = '#af0087',
    [127] = '#af00af',
    [128] = '#af00d7',
    [129] = '#af00ff',
    [130] = '#af5f00',
    [131] = '#af5f5f',
    [132] = '#af5f87',
    [133] = '#af5faf',
    [134] = '#af5fd7',
    [135] = '#af5fff',
    [136] = '#af8700',
    [137] = '#af875f',
    [138] = '#af8787',
    [139] = '#af87af',
    [140] = '#af87d7',
    [141] = '#af87ff',
    [142] = '#afaf00',
    [143] = '#afaf5f',
    [144] = '#afaf87',
    [145] = '#afafaf',
    [146] = '#afafd7',
    [147] = '#afafff',
    [148] = '#afd700',
    [149] = '#afd75f',
    [150] = '#afd787',
    [151] = '#afd7af',
    [152] = '#afd7d7',
    [153] = '#afd7ff',
    [154] = '#afff00',
    [155] = '#afff5f',
    [156] = '#afff87',
    [157] = '#afffaf',
    [158] = '#afffd7',
    [159] = '#afffff',
    [160] = '#d70000',
    [161] = '#d7005f',
    [162] = '#d70087',
    [163] = '#d700af',
    [164] = '#d700d7',
    [165] = '#d700ff',
    [166] = '#d75f00',
    [167] = '#d75f5f',
    [168] = '#d75f87',
    [169] = '#d75faf',
    [170] = '#d75fd7',
    [171] = '#d75fff',
    [172] = '#d78700',
    [173] = '#d7875f',
    [174] = '#d78787',
    [175] = '#d787af',
    [176] = '#d787d7',
    [177] = '#d787ff',
    [178] = '#d7af00',
    [179] = '#d7af5f',
    [180] = '#d7af87',
    [181] = '#d7afaf',
    [182] = '#d7afd7',
    [183] = '#d7afff',
    [184] = '#d7d700',
    [185] = '#d7d75f',
    [186] = '#d7d787',
    [187] = '#d7d7af',
    [188] = '#d7d7d7',
    [189] = '#d7d7ff',
    [190] = '#d7ff00',
    [191] = '#d7ff5f',
    [192] = '#d7ff87',
    [193] = '#d7ffaf',
    [194] = '#d7ffd7',
    [195] = '#d7ffff',
    [196] = '#ff0000',
    [197] = '#ff005f',
    [198] = '#ff0087',
    [199] = '#ff00af',
    [200] = '#ff00d7',
    [201] = '#ff00ff',
    [202] = '#ff5f00',
    [203] = '#ff5f5f',
    [204] = '#ff5f87',
    [205] = '#ff5faf',
    [206] = '#ff5fd7',
    [207] = '#ff5fff',
    [208] = '#ff8700',
    [209] = '#ff875f',
    [210] = '#ff8787',
    [211] = '#ff87af',
    [212] = '#ff87d7',
    [213] = '#ff87ff',
    [214] = '#ffaf00',
    [215] = '#ffaf5f',
    [216] = '#ffaf87',
    [217] = '#ffafaf',
    [218] = '#ffafd7',
    [219] = '#ffafff',
    [220] = '#ffd700',
    [221] = '#ffd75f',
    [222] = '#ffd787',
    [223] = '#ffd7af',
    [224] = '#ffd7d7',
    [225] = '#ffd7ff',
    [226] = '#ffff00',
    [227] = '#ffff5f',
    [228] = '#ffff87',
    [229] = '#ffffaf',
    [230] = '#ffffd7',
    [231] = '#ffffff',
    [232] = '#080808',
    [233] = '#121212',
    [234] = '#1c1c1c',
    [235] = '#262626',
    [236] = '#303030',
    [237] = '#3a3a3a',
    [238] = '#444444',
    [239] = '#4e4e4e',
    [240] = '#585858',
    [241] = '#626262',
    [242] = '#6c6c6c',
    [243] = '#767676',
    [244] = '#808080',
    [245] = '#8a8a8a',
    [246] = '#949494',
    [247] = '#9e9e9e',
    [248] = '#a8a8a8',
    [249] = '#b2b2b2',
    [250] = '#bcbcbc',
    [251] = '#c6c6c6',
    [252] = '#d0d0d0',
    [253] = '#dadada',
    [254] = '#e4e4e4',
    [255] = '#eeeeee'
}

M.blender = {}

local function update_color(colors)
    for i, value in ipairs(colors) do M.colormap[i - 1] = value end
end

local function update_blender(blenders)
    for key, value in pairs(blenders) do M.blender[key] = value end
end

function M.set_hl(name, options)
    -- options is the same as nvim_set_hl, except we set cterm value to fg, bg and sp instead of ctermxx
    if options.fg ~= nil then
        options.ctermfg = options.fg
        options.fg = M.colormap[options.fg]
    end
    if options.bg ~= nil then
        options.ctermbg = options.bg
        options.bg = M.colormap[options.bg]
    end
    if options.sp ~= nil then options.sp = M.colormap[options.sp] end
    vim.api.nvim_set_hl(0, name, options)
end

function M.setup()
    vim.o.termguicolors = true
    vim.o.pumblend = 1
    vim.o.winblend = 1

    update_color({
        '#202020', '#dd241d', '#98a71a', '#c76921', '#456588', '#d16286',
        '#288d7a', '#989898', '#737373', '#ff4934', '#b8db36', '#ea7d2f',
        '#8385a8', '#f3869b', '#7ec09c', '#d0d0d0'
    })
    update_blender({
        bg_lighter_1 = 235,
        bg_lighter_2 = 237,
        bg_lighter_3 = 239,
        bg_darker_1 = 234,
        bg_darker_2 = 233,
        bg_darker_3 = 232,
        fg_darker_1 = 249,
        fg_darker_2 = 246,
        fg_darker_3 = 243,
        add = 2,
        change = 4,
        delete = 1,
        error = 9,
        warn = 11,
        info = 12,
        hint = 2,
        scrollbar = 4,
        void = 234
    })

    M.set_hl('Normal', {fg = 15})
    M.set_hl('NonText', {fg = 10})
    M.set_hl('Whitespace', {fg = M.blender.bg_lighter_2})
    M.set_hl('VertSplit', {fg = M.blender.bg_lighter_2})
    M.set_hl('ColorColumn', {bg = M.blender.void})
    M.set_hl('CursorLine', {bg = M.blender.bg_lighter_1})
    M.set_hl('Folded', {
        bold = true,
        fg = 2,
        bg = M.blender.bg_lighter_2,
        sp = M.blender.fg_darker_3
    })
    M.set_hl('FoldColumn', {fg = M.blender.bg_lighter_2})
    M.set_hl('EndOfBuffer', {bg = M.blender.bg_darker_1})

    -- similar to lf file manager
    M.set_hl('Directory', {fg = 4, bold = true})

    M.set_hl('DiffAdd', {})
    M.set_hl('DiffDelete',
             {fg = M.blender.bg_darker_1, bg = M.blender.bg_darker_1})
    M.set_hl('DiffText', {underdashed = true})
    M.set_hl('DiffChange', {})

    M.set_hl('ErrorMsg', {fg = 9})
    M.set_hl('IncSearch', {fg = 15, bg = 2})
    M.set_hl('Search', {bg = 4})
    M.set_hl('MsgArea', {fg = M.blender.fg_darker_2})
    M.set_hl('MoreMsg', {fg = M.blender.fg_darker_2})

    -- Completion
    M.set_hl('Pmenu', {
        fg = M.blender.fg_darker_2,
        bg = M.blender.bg_lighter_2,
        blend = 10
    })
    M.set_hl('PmenuSel', {fg = 0, bg = 2, blend = 10})
    M.set_hl('PmenuSbar', {bg = M.blender.bg_lighter_3})
    M.set_hl('PmenuThumb', {bg = M.blender.scrollbar})

    -- Float
    M.set_hl('NormalFloat', {fg = 15, bg = M.blender.bg_lighter_1, blend = 10})
    M.set_hl('FloatBorder', {fg = 4, bg = M.blender.bg_lighter_1, blend = 10})
    M.set_hl('FloatTitle',
             {bold = true, fg = 10, bg = M.blender.bg_lighter_1, blend = 10})

    -- LSP Diagnostics
    M.set_hl('DiagnosticError', {fg = M.blender.error})
    M.set_hl('DiagnosticUnderlineError',
             {undercurl = true, sp = M.blender.error})
    M.set_hl('DiagnosticWarn', {fg = M.blender.warn})
    M.set_hl('DiagnosticUnderlineWarn', {undercurl = true, sp = M.blender.warn})
    M.set_hl('DiagnosticInfo', {fg = M.blender.info})
    M.set_hl('DiagnosticUnderlineInfo', {undercurl = true, sp = M.blender.info})
    M.set_hl('DiagnosticHint', {fg = M.blender.hint})
    M.set_hl('DiagnosticUnderlineHint', {undercurl = true, sp = M.blender.hint})

    M.set_hl('DiagnosticVirtualText',
             {undercurl = true, bold = true, fg = M.blender.fg_darker_3})
    M.set_hl('DiagnosticVirtualTextError', {link = 'DiagnosticVirtualText'})
    M.set_hl('DiagnosticVirtualTextWarn', {link = 'DiagnosticVirtualText'})
    M.set_hl('DiagnosticVirtualTextInfo', {link = 'DiagnosticVirtualText'})
    M.set_hl('DiagnosticVirtualTextHint', {link = 'DiagnosticVirtualText'})

    -- Gutter
    M.set_hl('LineNr', {fg = M.blender.fg_darker_3})
    M.set_hl('CursorLineNr', {})
    M.set_hl('SignColumn', {})

    M.set_hl('StatusLine', {})
    M.set_hl('Visual', {bg = M.blender.bg_lighter_2})

    -- :h treesitter-highlight-groups
    M.set_hl('NvimInternalError', {fg = M.blender.error})
    M.set_hl('Operator', {fg = 9})
    M.set_hl('SpecialChar', {bold = true, fg = 6})
    M.set_hl('Comment', {fg = M.blender.bg_lighter_3, italic = true})
    M.set_hl('String', {fg = 6})
    M.set_hl('Number', {link = 'String'})
    M.set_hl('Float', {link = 'String'})
    M.set_hl('Boolean', {link = 'Keyword'})
    M.set_hl('Character', {link = 'String'})
    M.set_hl('Keyword', {fg = 4, bold = true})
    M.set_hl('Conditional', {fg = 12, bold = true})
    M.set_hl('Repeat', {link = 'Conditional'})
    M.set_hl('Function', {fg = 10})
    M.set_hl('@function.builtin', {fg = 10, underdotted = true})
    M.set_hl('Identifier', {fg = M.blender.fg_darker_1})
    M.set_hl('Delimiter', {fg = 3})
    M.set_hl('Type', {fg = 11})
    M.set_hl('@constructor', {link = 'type'})
    M.set_hl('TypeDef', {fg = 11, bold = true})
    M.set_hl('Constant', {fg = 13, bold = true})
    M.set_hl('@constant.builtin', {fg = 13, underdotted = true, bold = true})
    M.set_hl('Include', {fg = 2, underdotted = true, bold = true})
    M.set_hl('Preproc', {fg = M.blender.bg_lighter_3})
    M.set_hl('Label', {fg = 6})
    M.set_hl('Tag', {fg = 6})
    M.set_hl('Title', {fg = 12, bold = true})
    M.set_hl('Exception', {fg = 1})
    M.set_hl('@text.literal', {link = "String"})
end

return M
