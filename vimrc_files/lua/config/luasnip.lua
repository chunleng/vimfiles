local M = {}

local ls = require("luasnip")
local s = require("luasnip.nodes.snippet").S
local sn = require("luasnip.nodes.snippet").SN
local isn = require("luasnip.nodes.snippet").ISN
local t = require("luasnip.nodes.textNode").T
local i = require("luasnip.nodes.insertNode").I
local f = require("luasnip.nodes.functionNode").F
local c = require("luasnip.nodes.choiceNode").C
local d = require("luasnip.nodes.dynamicNode").D
local r = require("luasnip.nodes.restoreNode").R
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet

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
    utils.noremap({'i', 's'}, '<c-j>', function() ls.change_choice(1) end)
    utils.noremap({'i', 's'}, '<c-k>', function() ls.change_choice(-1) end)
end

function M.setup()
    local theme = require('common-theme')
    theme.set_hl('LuaSnipSnippetPassive', {fg = 15})
    theme.set_hl('LuaSnipInsertNodeActiveVirtual',
                 {bold = true, fg = 0, bg = 11})
    theme.set_hl('LuaSnipInsertNodePassive', {fg = 3, underdotted = true})
    theme.set_hl('LuaSnipInsertNodeActive', {fg = 11})
    theme.set_hl('LuaSnipChoiceNodeActive', {link = 'Visual'})

    ls.setup({
        store_selection_keys = '<tab>',
        -- ref: https://github.com/L3MON4D3/LuaSnip/blob/master/lua/luasnip/config.lua#L122-L147
        snip_env = {
            s = s,
            sn = sn,
            isn = isn,
            t = t,
            i = i,
            f = f,
            c = c,
            d = d,
            r = r,
            events = events,
            ai = ai,
            extras = extras,
            l = l,
            rep = rep,
            p = p,
            m = m,
            n = n,
            dl = dl,
            fmt = fmt,
            fmta = fmta,
            conds = conds,
            postfix = postfix,
            types = types,
            parse = parse,
            -- customized
            v = function(jump_index, default_text)
                return d(jump_index, function(_, snip)
                    local visual = snip.env.LS_SELECT_RAW
                    return sn(nil,
                              {#visual > 0 and t(visual) or i(1, default_text)})
                end)
            end
        },
        ext_opts = {
            [types.snippet] = {
                passive = {
                    hl_group = 'LuaSnipSnippetPassive',
                    virt_text = {{' ‥ ', 'LuaSnipInsertNodeActiveVirtual'}}
                }
            },
            [types.insertNode] = {
                active = {hl_group = 'LuaSnipInsertNodeActive', priority = 2},
                passive = {hl_group = 'LuaSnipInsertNodePassive', priority = 2}
            },
            [types.choiceNode] = {
                active = {hl_group = 'LuaSnipChoiceNodeActive', priority = 1}
            }
        },
        load_ft_func = require('luasnip.extras.filetype_functions').extend_load_ft(
            {bash = {'sh'}})

    })
    require('luasnip.loaders.from_lua').load({
        paths = '~/.config/nvim/snippets/'
    })
    setup_mappings()
end

return M

