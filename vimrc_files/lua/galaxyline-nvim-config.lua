local gl = require('galaxyline')
local condition = require('galaxyline.condition')
local gps = require("nvim-gps")
local gls = gl.section
local base16 = require("base16-colorscheme")
gl.short_line_list = {'NvimTree', 'Trouble', 'aerial', 'dashboard'}

local bgcolor = base16.colorschemes["schemer-medium"].base00
local fgcolor = base16.colorschemes["schemer-medium"].base05

vim.highlight.create("StatusLine", {gui = "none", guibg = bgcolor}, false)
vim.highlight.create("StatusLineNC", {gui = "none", guibg = bgcolor}, false)

gls.left = {
    {
        FileIcon = {
            provider = 'FileIcon',
            condition = condition.buffer_not_empty,
            highlight = {
                require('galaxyline.provider_fileinfo').get_file_icon_color,
                bgcolor
            }
        }
    }, {
        FileName = {
            provider = 'FileName',
            condition = condition.buffer_not_empty,
            highlight = {fgcolor, bgcolor, 'bold'},
            separator = ' ',
            separator_highlight = {'NONE', bgcolor}
        }
    }, {
        diagnostic = {
            provider = function()
                local count = #vim.diagnostic.get(nil, {
                    severity = vim.diagnostic.severity.ERROR
                })

                return count > 0 and tostring(count) .. " " or nil
            end,
            icon = '  ',
            highlight = {base16.colors.base07, base16.colors.base08}
        }
    }
}

gls.mid = {
    {
        nvimGPS = {
            provider = function() return gps.get_location() end,
            condition = function() return gps.is_available() end,
            highlight = {fgcolor, bgcolor}
        }
    }
}

gls.right = {
    {
        LineInfo = {
            provider = function()
                local line = vim.fn.line('.')
                local total_line = vim.fn.line('$')
                local column = vim.fn.col('.')
                return string.format("%3d of %3d | %2d ", line, total_line,
                                     column)
            end,
            separator = ' ',
            separator_highlight = {'NONE', bgcolor},
            highlight = {fgcolor, bgcolor}
        }
    }, {
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

gls.short_line_left = {
    {
        SFileName = {
            provider = 'SFileName',
            condition = condition.buffer_not_empty,
            highlight = {fgcolor, bgcolor, 'bold'}
        }
    }
}

gls.short_line_right = {
    {BufferIcon = {provider = 'BufferIcon', highlight = {fgcolor, bgcolor}}}
}
