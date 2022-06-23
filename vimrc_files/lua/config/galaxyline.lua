local M = {}

function M.setup()
    local gl = require('galaxyline')
    local condition = require('galaxyline.condition')
    local gps = require("nvim-gps")
    local gls = gl.section
    local base16 = require("base16-colorscheme")

    local bgcolor = base16.colorschemes["schemer-medium"].base00
    local fgcolor = base16.colorschemes["schemer-medium"].base05

    vim.highlight.create("StatusLine", {gui = "none", guibg = bgcolor}, false)
    vim.highlight.create("StatusLineNC", {gui = "none", guibg = bgcolor}, false)

    gls.left = {
        {
            nvimGPS = {
                provider = function() return gps.get_location() end,
                condition = function() return gps.is_available() end,
                highlight = {fgcolor, bgcolor}
            }
        }, {
            LspError = {
                provider = function()
                    local count = #vim.diagnostic.get(nil, {
                        severity = vim.diagnostic.severity.ERROR
                    })

                    return count > 0 and tostring(count) .. " " or nil
                end,
                icon = '  ',
                separator = ' ',
                separator_highlight = {'NONE', bgcolor},
                highlight = {base16.colors.base07, base16.colors.base08}
            }
        }, {
            LspWarning = {
                provider = function()
                    local count = #vim.diagnostic.get(nil, {
                        severity = vim.diagnostic.severity.WARN
                    })

                    return count > 0 and tostring(count) .. " " or nil
                end,
                icon = '  ',
                separator = ' ',
                separator_highlight = {'NONE', bgcolor},
                highlight = {base16.colors.base00, base16.colors.base0A}
            }
        }
    }

    gls.right = {
        {
            FileEncode = {
                provider = 'FileEncode',
                condition = condition.hide_in_width,
                separator = ' ',
                separator_highlight = {'NONE', bgcolor},
                highlight = {base16.colors.base0B, bgcolor, 'bold'}
            }
        }, {
            FileFormat = {
                provider = 'FileFormat',
                condition = condition.hide_in_width,
                separator = ' ',
                separator_highlight = {'NONE', bgcolor},
                highlight = {base16.colors.base0B, bgcolor, 'bold'}
            }

        }, {
            GitIcon = {
                provider = function() return '  ' end,
                condition = condition.check_git_workspace,
                separator = ' ',
                separator_highlight = {'NONE', bgcolor},
                highlight = {base16.colors.base0E, bgcolor, 'bold'}
            }
        }, {
            GitBranch = {
                provider = 'GitBranch',
                condition = condition.check_git_workspace,
                highlight = {base16.colors.base0E, bgcolor, 'bold'}
            }
        }
    }
end

return M
