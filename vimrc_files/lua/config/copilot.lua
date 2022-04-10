local M = {}

function M.setup()
    vim.g.copilot_no_tab_map = 1
    vim.g.copilot_filetypes = {DressingInput = false}
    vim.api.nvim_set_keymap("i", "<c-space>", "copilot#Accept(\"\\<CR>\")",
                            {silent = true, script = true, expr = true})
end

return M
