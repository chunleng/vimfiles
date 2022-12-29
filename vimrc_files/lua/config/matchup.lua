local M = {}

function M.setup()
    vim.g.matchup_matchparen_offscreen = {method = ""}
    local theme = require('common-theme')
    theme.set_hl('MatchParen', {fg = 3, bold = true, underline = true})
    theme.set_hl('MatchWord', {fg = 3, bold = true})
end

return M
