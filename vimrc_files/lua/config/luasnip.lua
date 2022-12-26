local M = {}

local ls = require("luasnip")

local function setup_mappings()
    local utils = require('common-utils')
    utils.noremap('i', '<tab>', function()
        if ls.expandable() then
            ls.expand()
        else
            vim.api.nvim_eval([[feedkeys("\<tab>", "n")]])
        end
    end)
    utils.noremap({'i', 's'}, '<esc>', function()
        if ls.jumpable() then
            ls.jump(1)
        else
            vim.api.nvim_eval([[feedkeys("\<esc>", "n")]])
        end
    end)
end

function M.setup()
    ls.setup({store_selection_keys = '<tab>'})
    require('luasnip.loaders.from_lua').load({
        paths = '~/.config/nvim/snippets/'
    })
    setup_mappings()
end

return M

