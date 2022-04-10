local M = {}

function M.setup()
    local autopairs = require('nvim-autopairs')
    autopairs.setup {
        disable_in_macro = true,
        disable_in_visualblock = true,
        enable_afterquote = false,
        map_c_w = true,
        map_cr = true,
        check_ts = true
    }
end

return M
