local gl = require('galaxyline')
local condition = require('galaxyline.condition')
local gps = require("nvim-gps")
local gls = gl.section
local base16 = require("base16-colorscheme")
gl.short_line_list = {'NvimTree', 'Trouble', 'aerial', 'dashboard'}

local bgcolor = base16.colorschemes["schemer-medium"].base00
local fgcolor = base16.colorschemes["schemer-medium"].base05

vim.highlight.create("StatusLine", { gui="none", guibg = bgcolor}, false)
vim.highlight.create("StatusLineNC", { gui="none", guibg = bgcolor}, false)

gls.left[1] ={
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.buffer_not_empty,
    highlight = {
      require('galaxyline.provider_fileinfo').get_file_icon_color,
      bgcolor},
  },
}

gls.left[2] = {
  FileName = {
    provider = 'FileName',
    condition = condition.buffer_not_empty,
    highlight = {fgcolor,bgcolor,'bold'},
    separator = ' ',
    separator_highlight = {'NONE',bgcolor},
  }
}

gls.left[3] = {
  nvimGPS = {
    provider = function()
      return gps.get_location()
    end,
    condition = function()
      return gps.is_available()
    end,
    highlight = {fgcolor,bgcolor},
  }
}

gls.right[1] = {
  LineInfo = {
    provider = 'LineColumn',
    separator = ' ',
    separator_highlight = {'NONE',bgcolor},
    highlight = {fgcolor,bgcolor},
  },
}

gls.right[2] = {
  PerCent = {
    provider = 'LinePercent',
    separator = ' ',
    separator_highlight = {'NONE',bgcolor},
    highlight = {fgcolor,bgcolor,'bold'},
  }
}

gls.right[3] = {
  FileEncode = {
    provider = 'FileEncode',
    condition = condition.hide_in_width,
    separator = ' ',
    separator_highlight = {'NONE',bgcolor},
    highlight = {base16.colors.base0B,bgcolor,'bold'}
  }
}

gls.right[4] = {
  FileFormat = {
    provider = 'FileFormat',
    condition = condition.hide_in_width,
    separator = ' ',
    separator_highlight = {'NONE',bgcolor},
    highlight = {base16.colors.base0B,bgcolor,'bold'}
  }
}

gls.right[5] = {
  GitIcon = {
    provider = function() return '  ' end,
    condition = condition.check_git_workspace,
    separator = ' ',
    separator_highlight = {'NONE',bgcolor},
    highlight = {base16.colors.base0E,bgcolor,'bold'},
  }
}

gls.right[6] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = condition.check_git_workspace,
    highlight = {base16.colors.base0E,bgcolor,'bold'},
  }
}

gls.short_line_left[0] = {
  SFileName = {
    provider =  'SFileName',
    condition = condition.buffer_not_empty,
    highlight = {fgcolor,bgcolor,'bold'}
  }
}

gls.short_line_right[0] = {
  BufferIcon = {
    provider= 'BufferIcon',
    highlight = {fgcolor,bgcolor}
  }
}
