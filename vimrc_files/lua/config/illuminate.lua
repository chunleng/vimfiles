local M = {}

function M.setup()
    require("illuminate").configure({
        provider = {"regex"},
        filetypes_denylist = {
            "dashboard", "NvimTree", "aerial", "lsp-installer"
        },
        modes_allowlist = {'n'},
        delay = 100
    })

    local theme = require('common-theme')
    theme.set_hl('IlluminatedWordText', {underdotted = true})
    theme.set_hl('IlluminatedWordRead', {underdotted = true})
    theme.set_hl('IlluminatedWordWrite', {underdotted = true})
end

return M
