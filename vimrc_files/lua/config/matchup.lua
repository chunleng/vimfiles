local M = {}

function M.setup()
    vim.g.matchup_matchparen_offscreen = {method = ""}
    local theme = require('common-theme')
    theme.set_hl('MatchParen',
                 {fg = 1, bg = theme.blender.bg_lighter_1, bold = true})
    theme.set_hl('MatchWord', {bg = theme.blender.bg_lighter_1, bold = true})
end

return M
