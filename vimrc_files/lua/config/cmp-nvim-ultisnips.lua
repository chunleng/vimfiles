local M = {}

function M.setup()
    require("cmp_nvim_ultisnips").setup({filetype_source = "ultisnips_default"})
end

return M
