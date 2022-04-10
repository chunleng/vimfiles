local M = {}

function M.setup()
    vim.o.foldmethod = "expr"
    vim.o.foldexpr = "nvim_treesitter#foldexpr()"
    vim.o.foldlevelstart = 99

    require'nvim-treesitter.configs'.setup {
        ensure_installed = "maintained",
        highlight = {enable = true},
        matchup = {enable = true},
        -- Still really unstable
        -- indent = { enable = true },
        playground = {enable = true},
        context_commentstring = {enable = true},
        endwise = {enable = true},
        incremental_selection = {
            enable = true,
            keymaps = {
                node_incremental = "<enter>",
                scope_incremental = "+",
                node_decremental = "-"
            }
        }
    }
end

return M
