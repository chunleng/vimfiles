local M = {}

function M.setup()
    require("illuminate").configure({
        provider = {"regex"},
        filetypes_denylist = {
            "dashboard", "NvimTree", "aerial", "lsp-installer"
        },
        delay = 100
    })

    vim.api.nvim_set_hl(0, "IlluminatedWordText", {underline = true})

end

return M
