local M = {}

function M.setup()
    local gl = require('galaxyline')
    local condition = require('galaxyline.condition')
    local gps = require("nvim-gps")
    local gls = gl.section
    local theme = require('common-theme')

    local bgcolor = theme.colormap[theme.blender.bg_lighter_1]
    local fgcolor = theme.colormap[theme.blender.fg_darker_1]

    gls.left = {
        {
            LspError = {
                provider = function()
                    local count = #vim.diagnostic.get(nil, {
                        severity = vim.diagnostic.severity.ERROR
                    })

                    return count > 0 and tostring(count) .. " " or nil
                end,
                icon = '  ',
                separator = ' ',
                separator_highlight = {'none', bgcolor},
                highlight = {
                    theme.colormap[0], theme.colormap[theme.blender.error]
                }
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
                separator_highlight = {'none', bgcolor},
                highlight = {
                    theme.colormap[0], theme.colormap[theme.blender.warn]
                }
            }
        }, {
            nvimGPS = {
                provider = function() return gps.get_location() end,
                condition = function() return gps.is_available() end,
                highlight = {fgcolor, bgcolor}
            }
        }
    }

    gls.right = {
        {
            FileEncode = {
                provider = 'FileEncode',
                condition = condition.hide_in_width,
                separator = ' ',
                separator_highlight = {'none', bgcolor},
                highlight = {theme.colormap[3], bgcolor, 'bold'}
            }
        }, {
            FileFormat = {
                provider = 'FileFormat',
                condition = condition.hide_in_width,
                separator = ' ',
                separator_highlight = {'none', bgcolor},
                highlight = {theme.colormap[3], bgcolor, 'bold'}
            }

        }, {
            GitIcon = {
                provider = function() return '  ' end,
                condition = condition.check_git_workspace,
                separator = ' ',
                separator_highlight = {'none', bgcolor},
                highlight = {theme.colormap[5], bgcolor, 'bold'}
            }
        }, {
            GitBranch = {
                provider = 'GitBranch',
                condition = condition.check_git_workspace,
                highlight = {theme.colormap[5], bgcolor, 'bold'}
            }
        }
    }
end

return M
