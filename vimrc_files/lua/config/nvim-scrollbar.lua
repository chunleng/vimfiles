local M = {}

function M.setup()
    local base16 = require("base16-colorscheme")

    require("scrollbar").setup({
        handle = {color = base16.colors.base02},
        excluded_filetypes = {"WhichKey"},
        marks = {
            Search = {color = base16.colors.base0A_40},
            Error = {text = {"🬇", "▐"}, color = base16.colors.base08},
            Warn = {text = {"🬇", "▐"}, color = base16.colors.base0A},
            Info = {text = {"🬇", "▐"}, color = base16.colors.base0B},
            Hint = {text = {"🬇", "▐"}, color = base16.colors.base0D}
        }
    })
end

return M
