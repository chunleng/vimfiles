local M = {}

function M.setup()
    local base16 = require("base16-colorscheme")
    vim.api.nvim_set_hl(0, "OverLengthCustom",
                        {bg = base16.colors.base0D_20, fg = "none"})
    vim.api.nvim_set_keymap("n", "<leader>to", "<cmd>LengthmattersToggle<cr>",
                            {noremap = true, silent = true})
    vim.g.lengthmatters_excluded = {
        "Mundo", "MundoDiff", "NvimTree", "help", "qf", "WhichKey", "min",
        "markdown", "dashboard", "dbout"
    }
    vim.fn.call("lengthmatters#highlight_link_to", {'OverLengthCustom'})
end

return M
