local M = {}

function M.setup()
    vim.o.timeoutlen = 1000
    local wk = require("which-key")
    wk.setup({window = {winblend = 15}})
    wk.register({
        b = {name = "buffer"},
        c = {name = "code", t = {name = "test"}},
        d = {name = "dap"},
        g = {name = "git"},
        t = {name = "toggle"}
    }, {prefix = "<leader>"})
end

return M
