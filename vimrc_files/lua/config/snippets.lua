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

local neogen = require('neogen')

local theme = require('common-theme')
local utils = require('common-utils')

local function setup_luasnip()
    theme.set_hl('LuaSnipSnippetPassive', {fg = 15})
    theme.set_hl('LuaSnipInsertNodeActiveVirtual',
                 {bold = true, fg = 0, bg = 11})
    theme.set_hl('LuaSnipInsertNodePassive', {fg = 3, underdotted = true})
    theme.set_hl('LuaSnipInsertNodeActive', {fg = 11})
    theme.set_hl('LuaSnipChoiceNodeActive', {link = 'Visual'})

    ls.setup({
        update_events = 'TextChanged,TextChangedI',
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
            v = function(jump_index, default_text, editable)
                editable = editable and editable or false

                return d(jump_index, function(_, snip)
                    local visual = snip.env and snip.env.LS_SELECT_RAW or
                                       snip.snippet.env.LS_SELECT_RAW
                    return sn(nil, {
                        #visual == 0 and i(1, default_text) or
                            (editable and i(1, visual) or t(visual))
                    })
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
        }
    })
    ls.filetype_extend('bash', {'sh'})
    ls.filetype_extend('javascriptreact', {'javascript'})
    ls.filetype_extend('typescript', {'javascript'})
    ls.filetype_extend('typescriptreact',
                       {'javascriptreact', 'typescript', 'javascript'})

    require('luasnip.loaders').cleanup()
    require('luasnip.loaders.from_lua').load({
        paths = '~/.config/nvim/snippets/'
    })

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
            if not ls.jumpable() then
                vim.api.nvim_eval([[feedkeys("\<esc>", "n")]])
            end
        else
            vim.api.nvim_eval([[feedkeys("\<esc>", "n")]])
        end
    end)
    utils.noremap({'i', 's'}, '<c-j>', function() ls.change_choice(1) end)
    utils.noremap({'i', 's'}, '<c-k>', function() ls.change_choice(-1) end)
    -- Go into normal mode when deleting select to improve completion flow
    utils.noremap({'s'}, '<bs>', '<bs>i')
end

local function setup_neogen()
    local languages_supported = {'python', 'lua'}
    local convention = {}

    local function d_generate_doc(type)
        return d(1, function()
            local snippet =
                neogen.generate({type = type, return_snippet = true})
            if snippet == nil then return sn(nil, t('')) end
            return sn(nil, parse(nil, table.concat(snippet, '\n')))
        end, {})
    end

    for _, language in ipairs(languages_supported) do
        ls.add_snippets(language, {
            s({trig = 'd', dscr = 'Template for file code documentation'},
              d_generate_doc('file')),
            s({trig = 'dc', dscr = 'Template for class code documentation'},
              d_generate_doc('class')),
            s({trig = 'df', dscr = 'Template for function code documentation'},
              d_generate_doc('func'))
        })
        local lang_convention = os.getenv('DOC_CONV_' .. string.upper(language))
        if lang_convention ~= nil then
            convention[language] = {
                template = {annotation_convention = lang_convention}
            }
        end
    end

    neogen.setup({
        snippet_engine = 'luasnip',
        placeholders_text = {
            description = '[desc]',
            tparam = '[param]',
            parameter = '[param]',
            ['return'] = '[return]',
            class = '[class]',
            throw = '[throws',
            varargs = '[args]',
            type = '[type]',
            attribute = '[attr]',
            args = '[args]',
            kwargs = '[args]'
        },
        languages = convention
    })
end

function M.setup()
    setup_luasnip()
    setup_neogen()
end

return M

