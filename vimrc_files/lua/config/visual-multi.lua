local M = {}

function M.setup()
    vim.g.VM_default_mappings = 0
    vim.g.VM_mouse_mappings = 0
    vim.g.VM_maps = {
        ["Find Under"] = "\\",
        ["Find Subword Under"] = "\\",
        ["Select All"] = "g\\"
    }
end

return M
