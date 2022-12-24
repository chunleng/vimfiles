local M = {}

function M.setup()
    vim.g["test#strategy"] = "kitty"
    vim.g["test#preserve_screen"] = 1

    local utils = require('common-utils')
    utils.noremap("n", "<leader>ctf", "<cmd>TestFile<cr>")
    utils.noremap("n", "<leader>ctn", "<cmd>TestNearest<cr>")
    utils.noremap("n", "<leader>ctt", "<cmd>TestSuite<cr>")
end

return M
