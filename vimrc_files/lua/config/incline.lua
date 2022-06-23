local M = {}

function M.setup()
    local base16 = require("base16-colorscheme")

    vim.highlight.create("InclineNormal", {
        gui = "none",
        guifg = base16.colors.base06,
        guibg = base16.colors.base0D_40,
        blend = 0
    }, false)
    vim.highlight.create("InclineNormalNC", {
        gui = "none",
        guifg = base16.colors.base03,
        guibg = base16.colors.base01,
        blend = 0
    }, false)

    require("incline").setup({
        render = function(props)
            local bufname = vim.api.nvim_buf_get_name(props.buf)
            local f_name, f_extension = vim.fn.fnamemodify(bufname, ":t"),
                                        vim.fn.fnamemodify(bufname, ":e")
            local icon = require("nvim-web-devicons").get_icon(f_name,
                                                               f_extension,
                                                               {default = true})
            return icon .. " " .. f_name
        end,
        window = {margin = {vertical = 0}},
        hide = {only_win = true},
        highlight = {
            groups = {
                InclineNormal = "InclineNormal",
                InclineNormalNC = "InclineNormalNC"
            }
        }
    })
end

return M
